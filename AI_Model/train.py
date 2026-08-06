import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib



# Load dataset

data = pd.read_csv(
    "dataset/wellness_data.csv"
)


print("Dataset loaded")
print(data.head())



# Separate input and output

X = data[
    [
        "sleep_hours",
        "water_intake",
        "exercise_minutes",
        "stress_level",
        "mood_score"
    ]
]


y = data["wellness_status"]



# Split data

X_train, X_test, y_train, y_test = train_test_split(

    X,
    y,
    test_size=0.2,
    random_state=42

)



# Create model

model = RandomForestClassifier(

    n_estimators=100,

    random_state=42

)



# Train

model.fit(

    X_train,

    y_train

)



# Accuracy

accuracy = model.score(

    X_test,

    y_test

)


print(
    "Model Accuracy:",
    accuracy
)



# Save model

joblib.dump(

    model,

    "model/wellness_model.pkl"

)


print(
    "Model saved successfully"
)