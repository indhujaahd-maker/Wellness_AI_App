import pandas as pd
import joblib
from pathlib import Path


# --------------------------------------------------
# Wellness AI - Prediction System
# --------------------------------------------------

BASE_DIR = Path(__file__).resolve().parent

MODEL_FILE = BASE_DIR / "model" / "wellness_model.pkl"


# --------------------------------------------------
# Load trained model
# --------------------------------------------------

print("Loading Wellness AI model...")

model = joblib.load(MODEL_FILE)

print("Model loaded successfully!")


# --------------------------------------------------
# Prediction function
# --------------------------------------------------

def predict_wellness(
    sleep_hours,
    water_intake,
    exercise_minutes,
    stress_level,
    mood_score
):

    # Use a DataFrame so feature names match
    # the features used during model training.

    input_data = pd.DataFrame([{
        "sleep_hours": sleep_hours,
        "water_intake": water_intake,
        "exercise_minutes": exercise_minutes,
        "stress_level": stress_level,
        "mood_score": mood_score
    }])

    # Predict wellness category
    prediction = model.predict(input_data)[0]

    # Get prediction probabilities
    probabilities = model.predict_proba(input_data)[0]

    # Calculate confidence
    confidence = max(probabilities) * 100

    return prediction, confidence


# --------------------------------------------------
# Recommendation System
# --------------------------------------------------

def generate_recommendation(
    sleep_hours,
    water_intake,
    exercise_minutes,
    stress_level,
    mood_score,
    wellness_status
):

    recommendations = []

    # Sleep recommendation
    if sleep_hours < 7:

        recommendations.append(
            "Try to get more sleep and maintain a consistent sleep schedule."
        )

    # Water recommendation
    if water_intake < 6:

        recommendations.append(
            "Consider increasing your water intake throughout the day."
        )

    # Exercise recommendation
    if exercise_minutes < 20:

        recommendations.append(
            "A short walk or light physical activity may help improve your energy."
        )

    # Stress recommendation
    if stress_level >= 7:

        recommendations.append(
            "Your reported stress level is high. "
            "Consider taking a short break, "
            "trying slow breathing, or talking to someone you trust."
        )

    # Mood recommendation
    if mood_score <= 4:

        recommendations.append(
            "Your mood score is relatively low today. "
            "Consider checking in with yourself "
            "and doing something supportive or enjoyable."
        )

    # If everything looks reasonably balanced
    if not recommendations:

        recommendations.append(
            "Your current wellness indicators look balanced. "
            "Keep maintaining your healthy habits."
        )

    return recommendations


# --------------------------------------------------
# Interactive Prediction
# --------------------------------------------------

def main():

    print("\n========================================")
    print("        WELLNESS AI COMPANION")
    print("========================================")

    print("\nEnter today's wellness information.\n")


    # ----------------------------------------------
    # Get user information
    # ----------------------------------------------

    sleep_hours = float(
        input("Sleep hours: ")
    )

    water_intake = float(
        input("Water intake (glasses): ")
    )

    exercise_minutes = float(
        input("Exercise minutes: ")
    )

    stress_level = int(
        input("Stress level (1-10): ")
    )

    mood_score = int(
        input("Mood score (1-10): ")
    )


    # ----------------------------------------------
    # Predict wellness
    # ----------------------------------------------

    wellness_status, confidence = predict_wellness(
        sleep_hours,
        water_intake,
        exercise_minutes,
        stress_level,
        mood_score
    )


    # ----------------------------------------------
    # Generate recommendations
    # ----------------------------------------------

    recommendations = generate_recommendation(
        sleep_hours,
        water_intake,
        exercise_minutes,
        stress_level,
        mood_score,
        wellness_status
    )


    # ----------------------------------------------
    # Display result
    # ----------------------------------------------

    print("\n========================================")
    print("          WELLNESS RESULT")
    print("========================================")

    print(
        f"\nWellness Status: {wellness_status}"
    )

    print(
        f"Model Confidence: {confidence:.2f}%"
    )


    print("\nPersonalized Suggestions:")


    for number, recommendation in enumerate(
        recommendations,
        start=1
    ):

        print(
            f"{number}. {recommendation}"
        )


    print("\n========================================")
    print("Remember: This is a wellness prototype,")
    print("not a medical diagnostic system.")
    print("========================================")


# --------------------------------------------------
# Start Program
# --------------------------------------------------

if __name__ == "__main__":
    main()