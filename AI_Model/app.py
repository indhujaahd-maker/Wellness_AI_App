from flask import Flask, request, jsonify
from flask_cors import CORS

from ai_companion import WellnessCompanion


# --------------------------------------------------
# Flask Application
# --------------------------------------------------

app = Flask(__name__)

CORS(
    app,
    resources={
        r"/*": {
            "origins": "*"
        }
    }
)


# --------------------------------------------------
# AI Companion
# --------------------------------------------------

companion = WellnessCompanion()


# --------------------------------------------------
# Health Check
# --------------------------------------------------

@app.route("/", methods=["GET"])
def home():

    return jsonify({
        "status": "success",
        "message": "Wellness AI API is running"
    })


# --------------------------------------------------
# Chat Endpoint
# --------------------------------------------------

@app.route("/chat", methods=["POST"])
def chat():

    try:

        data = request.get_json()

        if not data:

            return jsonify({
                "status": "error",
                "message": "No data received"
            }), 400


        user_message = data.get(
            "message",
            ""
        ).strip()


        if not user_message:

            return jsonify({
                "status": "error",
                "message": "Message cannot be empty"
            }), 400


        # Generate AI response
        response = companion.generate_response(
            user_message
        )


        return jsonify({

            "status": "success",

            "user_message": user_message,

            "response": response

        })


    except Exception as e:

        return jsonify({

            "status": "error",

            "message": str(e)

        }), 500


# --------------------------------------------------
# Delete Conversation
# --------------------------------------------------

@app.route("/delete-conversation", methods=["DELETE"])
def delete_conversation():

    try:

        message = companion.delete_conversation()


        return jsonify({

            "status": "success",

            "message": message

        })


    except Exception as e:

        return jsonify({

            "status": "error",

            "message": str(e)

        }), 500


# --------------------------------------------------
# Start Server
# --------------------------------------------------

if __name__ == "__main__":

    print("\n========================================")
    print("       WELLNESS AI API SERVER")
    print("========================================")

    print("\nServer running at:")
    print("http://127.0.0.1:5000")

    print("\nAvailable endpoints:")
    print("GET  /")
    print("POST /chat")
    print("DELETE /delete-conversation")

    print("\nPress CTRL+C to stop the server.\n")


    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )