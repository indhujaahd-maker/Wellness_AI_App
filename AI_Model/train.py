import pandas as pd
import joblib

from pathlib import Path

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix


# --------------------------------------------------
# Wellness AI - Model Training
# --------------------------------------------------

BASE_DIR = Path(__file__).resolve().parent

DATASET_FILE = BASE_DIR / "dataset" / "wellness_data.csv"
MODEL_DIR = BASE_DIR / "model"
MODEL_FILE = MODEL_DIR / "wellness_model.pkl"


# --------------------------------------------------
# 1. Load dataset
# --------------------------------------------------

print("Loading wellness dataset...")

data = pd.read_csv(DATASET_FILE)

print("Dataset loaded successfully!")
print(f"Total records: {len(data)}")

print("\nFirst 5 records:")
print(data.head())


# --------------------------------------------------
# 2. Separate features and target
# --------------------------------------------------

features = [
    "sleep_hours",
    "water_intake",
    "exercise_minutes",
    "stress_level",
    "mood_score"
]

target = "wellness_status"


X = data[features]
y = data[target]


# --------------------------------------------------
# 3. Split dataset
# --------------------------------------------------

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.20,
    random_state=42,
    stratify=y
)


print("\nTraining records:", len(X_train))
print("Testing records:", len(X_test))


# --------------------------------------------------
# 4. Create Random Forest model
# --------------------------------------------------

print("\nTraining Wellness AI model...")

model = RandomForestClassifier(
    n_estimators=200,
    random_state=42,
    max_depth=10
)


# --------------------------------------------------
# 5. Train
# --------------------------------------------------

model.fit(X_train, y_train)

print("Model training completed!")


# --------------------------------------------------
# 6. Test model
# --------------------------------------------------

predictions = model.predict(X_test)

accuracy = accuracy_score(y_test, predictions)

print("\n========================================")
print("MODEL PERFORMANCE")
print("========================================")

print(f"Accuracy: {accuracy * 100:.2f}%")


print("\nClassification Report:")
print(
    classification_report(
        y_test,
        predictions,
        zero_division=0
    )
)


print("\nConfusion Matrix:")
print(
    confusion_matrix(
        y_test,
        predictions
    )
)


# --------------------------------------------------
# 7. Feature importance
# --------------------------------------------------

print("\n========================================")
print("FEATURE IMPORTANCE")
print("========================================")

importance = model.feature_importances_

for feature, value in zip(features, importance):

    print(
        f"{feature}: {value:.4f}"
    )


# --------------------------------------------------
# 8. Save model
# --------------------------------------------------

MODEL_DIR.mkdir(exist_ok=True)

joblib.dump(
    model,
    MODEL_FILE
)

print("\n========================================")
print("MODEL SAVED SUCCESSFULLY")
print("========================================")

print(f"Model location: {MODEL_FILE}")