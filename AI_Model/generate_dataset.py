import csv
import random
from pathlib import Path

# --------------------------------------------------
# Wellness AI - Synthetic Dataset Generator
# --------------------------------------------------

random.seed(42)

BASE_DIR = Path(__file__).resolve().parent
DATASET_DIR = BASE_DIR / "dataset"
DATASET_DIR.mkdir(exist_ok=True)

OUTPUT_FILE = DATASET_DIR / "wellness_data.csv"

NUM_RECORDS = 1000


def calculate_wellness_status(
    sleep_hours,
    water_intake,
    exercise_minutes,
    stress_level,
    mood_score
):
    """
    Generate a wellness category from the input features.

    This is a synthetic rule used to create prototype
    training data. It is NOT a medical diagnostic rule.
    """

    score = 0

    # Sleep
    if 7 <= sleep_hours <= 9:
        score += 2
    elif 6 <= sleep_hours < 7 or 9 < sleep_hours <= 10:
        score += 1
    else:
        score -= 1

    # Water
    if water_intake >= 7:
        score += 2
    elif water_intake >= 5:
        score += 1
    else:
        score -= 1

    # Exercise
    if exercise_minutes >= 45:
        score += 2
    elif exercise_minutes >= 20:
        score += 1
    else:
        score -= 1

    # Stress
    if stress_level <= 3:
        score += 2
    elif stress_level <= 6:
        score += 1
    else:
        score -= 2

    # Mood
    if mood_score >= 8:
        score += 2
    elif mood_score >= 6:
        score += 1
    elif mood_score <= 3:
        score -= 2

    # Final category
    if score >= 7:
        return "Excellent"
    elif score >= 4:
        return "Good"
    elif score >= 1:
        return "Average"
    else:
        return "Needs Attention"


def generate_record():
    sleep_hours = round(random.uniform(4, 10), 1)

    water_intake = random.randint(2, 10)

    exercise_minutes = random.randint(0, 90)

    stress_level = random.randint(1, 10)

    mood_score = random.randint(1, 10)

    wellness_status = calculate_wellness_status(
        sleep_hours,
        water_intake,
        exercise_minutes,
        stress_level,
        mood_score
    )

    return [
        sleep_hours,
        water_intake,
        exercise_minutes,
        stress_level,
        mood_score,
        wellness_status
    ]


def main():

    headers = [
        "sleep_hours",
        "water_intake",
        "exercise_minutes",
        "stress_level",
        "mood_score",
        "wellness_status"
    ]

    records = []

    for _ in range(NUM_RECORDS):
        records.append(generate_record())

    with open(
        OUTPUT_FILE,
        "w",
        newline="",
        encoding="utf-8"
    ) as file:

        writer = csv.writer(file)

        writer.writerow(headers)
        writer.writerows(records)

    print("========================================")
    print("Wellness dataset generated successfully!")
    print("========================================")
    print(f"Records generated: {NUM_RECORDS}")
    print(f"Dataset location: {OUTPUT_FILE}")
    print()
    print("Features:")
    print("- sleep_hours")
    print("- water_intake")
    print("- exercise_minutes")
    print("- stress_level")
    print("- mood_score")
    print()
    print("Target:")
    print("- wellness_status")
    print()
    print("Categories:")
    print("- Excellent")
    print("- Good")
    print("- Average")
    print("- Needs Attention")


if __name__ == "__main__":
    main()