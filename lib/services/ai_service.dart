class AIService {


  String getRecommendation({

    required int mood,

    required int stress,

    required double sleep,

    required int water,

    required int exercise,

  }) {


    if(stress >= 8){

      return "Your stress level seems high. Try breathing exercises, meditation, and talking to someone you trust.";

    }


    if(sleep < 5){

      return "Your sleep duration is low. Improving sleep may help your mood and energy.";

    }


    if(water < 4){

      return "Your water intake is low. Drink more water to support concentration and energy.";

    }


    if(exercise < 15){

      return "Try adding some physical activity today. Even a short walk can improve mood.";

    }


    if(mood < 5){

      return "Your mood score seems low today. Try journaling or a calming activity.";

    }


    return "Your wellness indicators look balanced. Keep maintaining your healthy routine.";

  }



  String panicSupport(){

    return """

Let's try grounding together.

Look around and identify:

5 things you can see

4 things you can touch

3 things you can hear

2 things you can smell

1 thing you can taste


Remember: You are safe in this moment.

""";

  }


}