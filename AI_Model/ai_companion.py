import json
from pathlib import Path
from datetime import datetime


# --------------------------------------------------
# Wellness AI - Persistent AI Companion
# --------------------------------------------------

BASE_DIR = Path(__file__).resolve().parent

MEMORY_FILE = BASE_DIR / "conversation_memory.json"


class WellnessCompanion:

    def __init__(self):

        self.conversation_history = []
        self.user_context = {}

        self.load_memory()


    # --------------------------------------------------
    # Load previous conversation
    # --------------------------------------------------

    def load_memory(self):

        if not MEMORY_FILE.exists():

            self.conversation_history = []
            self.user_context = {}

            return

        try:

            with open(
                MEMORY_FILE,
                "r",
                encoding="utf-8"
            ) as file:

                data = json.load(file)

            self.conversation_history = data.get(
                "conversation_history",
                []
            )

            self.user_context = data.get(
                "user_context",
                {}
            )

            print(
                f"Loaded {len(self.conversation_history)} "
                "previous conversation messages."
            )

        except Exception:

            print(
                "Unable to load previous memory. "
                "Starting a new conversation."
            )

            self.conversation_history = []
            self.user_context = {}


    # --------------------------------------------------
    # Save memory
    # --------------------------------------------------

    def save_memory(self):

        data = {

            "conversation_history":
                self.conversation_history,

            "user_context":
                self.user_context

        }

        with open(
            MEMORY_FILE,
            "w",
            encoding="utf-8"
        ) as file:

            json.dump(
                data,
                file,
                indent=4,
                ensure_ascii=False
            )


    # --------------------------------------------------
    # Remember conversation
    # --------------------------------------------------

    def remember(
        self,
        user_message,
        ai_response
    ):

        self.conversation_history.append({

            "user": user_message,

            "ai": ai_response,

            "time":
                datetime.now().strftime(
                    "%Y-%m-%d %H:%M:%S"
                )

        })

        self.save_memory()


    # --------------------------------------------------
    # Delete conversation
    # --------------------------------------------------

    def delete_conversation(self):

        self.conversation_history = []

        self.user_context = {}

        if MEMORY_FILE.exists():

            MEMORY_FILE.unlink()

        return (
            "Your conversation history has been "
            "deleted successfully."
        )


    # --------------------------------------------------
    # Update context
    # --------------------------------------------------

    def update_context(self, message):

        text = message.lower()


        # Stress
        if (
            "stress" in text
            or "stressed" in text
        ):

            self.user_context["stress"] = True


        # Sadness
        if (
            "sad" in text
            or "unhappy" in text
            or "feeling low" in text
        ):

            self.user_context["low_mood"] = True


        # Sleep
        if (
            "sleep" in text
            or "slept" in text
        ):

            self.user_context["sleep"] = True


        # College / exams
        if (
            "college" in text
            or "exam" in text
            or "assignment" in text
        ):

            self.user_context["college"] = True


        # Work
        if (
            "work" in text
            or "job" in text
            or "office" in text
        ):

            self.user_context["work"] = True


        # Family
        if (
            "family" in text
            or "parents" in text
        ):

            self.user_context["family"] = True


    # --------------------------------------------------
    # Crisis detection
    # --------------------------------------------------

    def is_crisis_message(self, message):

        text = message.lower()

        crisis_words = [

            "kill myself",

            "suicide",

            "suicidal",

            "end my life",

            "want to die",

            "don't want to live",

            "do not want to live",

            "hurt myself",

            "self harm",

            "self-harm"

        ]

        return any(
            phrase in text
            for phrase in crisis_words
        )


    # --------------------------------------------------
    # Crisis response
    # --------------------------------------------------

    def crisis_response(self):

        return (

            "I'm really sorry you're going through "
            "something this painful. I'm here to listen, "
            "but I can't provide the immediate help that "
            "a trained professional can. Please consider "
            "contacting someone you trust or a qualified "
            "mental-health professional right now. "
            "If you are in immediate danger, please "
            "contact your local emergency service."

        )


    # --------------------------------------------------
    # Retrieve recent conversation
    # --------------------------------------------------

    def get_recent_context(self, number=5):

        if not self.conversation_history:

            return []

        return self.conversation_history[-number:]


    # --------------------------------------------------
    # Generate response
    # --------------------------------------------------

    def generate_response(self, message):

        text = message.lower().strip()


        # --------------------------------------------------
        # Delete conversation command
        # --------------------------------------------------

        delete_commands = [

            "delete my conversation",

            "delete my chat",

            "delete chat",

            "clear conversation",

            "clear my chat",

            "forget everything",

            "forget our conversation"

        ]

        if any(
            command in text
            for command in delete_commands
        ):

            return self.delete_conversation()


        # --------------------------------------------------
        # Update context
        # --------------------------------------------------

        self.update_context(message)


        # --------------------------------------------------
        # Crisis detection
        # --------------------------------------------------

        if self.is_crisis_message(message):

            response = self.crisis_response()

            self.remember(
                message,
                response
            )

            return response


        # --------------------------------------------------
        # Greetings
        # --------------------------------------------------

        if text in [

            "hi",
            "hello",
            "hey",
            "hey there",
            "hi there"

        ]:

            response = (

                "Hey! 👋 I'm glad you're here. "
                "How are you feeling today?"

            )


        # --------------------------------------------------
        # Not feeling good
        # --------------------------------------------------

        elif (

            "not feeling good" in text
            or "don't feel good" in text
            or "dont feel good" in text
            or "feeling bad" in text

        ):

            response = (

                "I'm sorry you're having a rough day. "
                "You don't have to deal with it alone. "
                "Want to tell me what's going on?"

            )


        # --------------------------------------------------
        # Sad
        # --------------------------------------------------

        elif (

            "i am sad" in text
            or "i'm sad" in text
            or "feeling sad" in text

        ):

            response = (

                "I'm sorry you're feeling this way. "
                "Want to tell me what happened?"

            )


        # --------------------------------------------------
        # Stressed
        # --------------------------------------------------

        elif (

            "i am stressed" in text
            or "i'm stressed" in text
            or "feeling stressed" in text
            or text == "stressed"

        ):

            response = (

                "That sounds difficult. Take a breath "
                "for a moment. What's causing most of "
                "the stress right now?"

            )


        # --------------------------------------------------
        # Tired
        # --------------------------------------------------

        elif (

            "i am tired" in text
            or "i'm tired" in text
            or "feeling tired" in text

        ):

            response = (

                "You sound like you could really use "
                "some rest. How much sleep did you get "
                "last night?"

            )


        # --------------------------------------------------
        # College / exam
        # --------------------------------------------------

        elif (

            "exam" in text
            or "college" in text
            or "assignment" in text

        ):

            response = (

                "That sounds stressful. Is it the "
                "workload, the exam itself, or something "
                "else that's worrying you?"

            )


        # --------------------------------------------------
        # Work
        # --------------------------------------------------

        elif (

            "work" in text
            or "job" in text
            or "office" in text

        ):

            response = (

                "Work can take a lot out of us. "
                "What's been happening?"

            )


        # --------------------------------------------------
        # How are you
        # --------------------------------------------------

        elif (

            "how are you" in text
            or "how are u" in text

        ):

            response = (

                "I'm doing well 😊 "
                "More importantly, how are you doing?"

            )


        # --------------------------------------------------
        # Thanks
        # --------------------------------------------------

        elif (

            "thank you" in text
            or "thanks" in text

        ):

            response = (

                "You're welcome! 😊 "
                "I'm happy to listen."

            )


        # --------------------------------------------------
        # Okay
        # --------------------------------------------------

        elif text in [

            "okay",
            "ok",
            "alright"

        ]:

            response = (

                "Okay. I'm here with you. "
                "What would you like to talk about?"

            )


        # --------------------------------------------------
        # Help
        # --------------------------------------------------

        elif (

            "help me" in text
            or "i need help" in text

        ):

            response = (

                "Of course. Tell me what's happening, "
                "and we'll take it one step at a time."

            )


        # --------------------------------------------------
        # Context-aware response
        # --------------------------------------------------

        elif self.user_context.get("college"):

            response = (

                "You mentioned college earlier. "
                "Do you want to tell me more about "
                "what's happening?"

            )


        elif self.user_context.get("work"):

            response = (

                "You mentioned work earlier. "
                "Do you want to tell me more about it?"

            )


        elif self.user_context.get("stress"):

            response = (

                "I remember you mentioned feeling "
                "stressed earlier. How are you feeling "
                "about it now?"

            )


        elif self.user_context.get("low_mood"):

            response = (

                "I remember you mentioned feeling low "
                "earlier. How are you feeling now?"

            )


        # --------------------------------------------------
        # Generic response
        # --------------------------------------------------

        else:

            response = (

                "I'm listening. Tell me a little more "
                "about what's on your mind."

            )


        # --------------------------------------------------
        # Save conversation
        # --------------------------------------------------

        self.remember(
            message,
            response
        )


        return response


# --------------------------------------------------
# Terminal chat
# --------------------------------------------------

def main():

    companion = WellnessCompanion()


    print("\n========================================")

    print(
        "       WELLNESS AI COMPANION"
    )

    print(
        "========================================"
    )


    print(
        "\nYour conversation will be remembered."
    )

    print(
        "Type 'delete my conversation' "
        "to erase your saved conversation."
    )

    print(
        "Type 'exit' to close the companion.\n"
    )


    while True:

        user_message = input(
            "You: "
        ).strip()


        # Exit
        if user_message.lower() in [

            "exit",
            "quit",
            "bye"

        ]:

            print(

                "\nAI: Take care of yourself. "
                "I'll be here whenever you want "
                "to talk. ❤️"

            )

            break


        # Empty input
        if not user_message:

            print(

                "AI: I'm listening. "
                "Tell me what's on your mind.\n"

            )

            continue


        response = companion.generate_response(
            user_message
        )


        print(
            f"\nAI: {response}\n"
        )


# --------------------------------------------------
# Start
# --------------------------------------------------

if __name__ == "__main__":

    main()