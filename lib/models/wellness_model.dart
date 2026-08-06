class WellnessModel {


  final int mood;
  final int stress;
  final double sleepHours;
  final int waterIntake;
  final int exerciseMinutes;


  WellnessModel({

    required this.mood,
    required this.stress,
    required this.sleepHours,
    required this.waterIntake,
    required this.exerciseMinutes,

  });



  Map<String,dynamic> toJson(){

    return {

      "mood":mood,

      "stress":stress,

      "sleepHours":sleepHours,

      "waterIntake":waterIntake,

      "exerciseMinutes":exerciseMinutes,

    };

  }



}