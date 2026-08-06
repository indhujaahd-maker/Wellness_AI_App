import joblib
import numpy as np



# Load model

model = joblib.load(

    "model/wellness_model.pkl"

)



def predict_wellness(

    sleep,

    water,

    exercise,

    stress,

    mood

):


    data = np.array(

        [
            [
                sleep,
                water,
                exercise,
                stress,
                mood
            ]
        ]

    )


    prediction = model.predict(data)


    return prediction[0]




result = predict_wellness(

    6,

    5,

    20,

    5,

    6

)


print(

    "Wellness Prediction:",

    result

)