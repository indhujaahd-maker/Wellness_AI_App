import 'package:flutter/material.dart';
import 'dashboard_screen.dart';


class AssessmentScreen extends StatefulWidget {

  final String gender;


  const AssessmentScreen({

    super.key,

    required this.gender,

  });



  @override
  State<AssessmentScreen> createState()=>_AssessmentScreenState();

}



class _AssessmentScreenState extends State<AssessmentScreen>{


  int currentQuestion = 0;


  final List<String> questions=[

    "How is your energy level today?",

    "How many hours do you sleep?",

    "How stressed do you feel?",

    "How is your mood today?",

    "How much water do you drink?"

  ];



  void nextQuestion(){


    if(currentQuestion < questions.length-1){


      setState((){

        currentQuestion++;

      });


    }

    else{


      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder:(context)=>const DashboardScreen(),

        ),

      );


    }

  }



  @override
  Widget build(BuildContext context){


    return Scaffold(

      appBar:AppBar(

        title:const Text("Wellness Assessment"),

      ),


      body:Padding(

        padding:const EdgeInsets.all(25),


        child:Column(

          mainAxisAlignment:MainAxisAlignment.center,

          children:[


            Text(

              "Question ${currentQuestion+1}/${questions.length}",

              style:const TextStyle(

                fontSize:18,

              ),

            ),



            const SizedBox(height:30),



            Text(

              questions[currentQuestion],

              style:const TextStyle(

                fontSize:26,

                fontWeight:FontWeight.bold,

              ),

              textAlign:TextAlign.center,

            ),



            const SizedBox(height:30),



            TextField(

              decoration:const InputDecoration(

                hintText:"Your answer",

                border:OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:30),



            ElevatedButton(

              onPressed:nextQuestion,

              child:const Text("Next"),

            )


          ],

        ),

      ),

    );

  }

}