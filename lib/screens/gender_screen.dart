import 'package:flutter/material.dart';
import 'assessment_screen.dart';


class GenderScreen extends StatelessWidget {

  const GenderScreen({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title: const Text("Choose Gender"),

      ),


      body: Padding(

        padding: const EdgeInsets.all(25),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [


            const Text(

              "Help us understand you better",

              style: TextStyle(

                fontSize:28,

                fontWeight:FontWeight.bold,

              ),

            ),


            const SizedBox(height:40),



            ElevatedButton(

              style: ElevatedButton.styleFrom(

                minimumSize: const Size(double.infinity,50),

              ),

              onPressed:(){

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>const AssessmentScreen(

                      gender:"Female",

                    ),

                  ),

                );

              },

              child:const Text("Female"),

            ),



            const SizedBox(height:20),



            ElevatedButton(

              style: ElevatedButton.styleFrom(

                minimumSize: const Size(double.infinity,50),

              ),

              onPressed:(){

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>const AssessmentScreen(

                      gender:"Male",

                    ),

                  ),

                );

              },

              child:const Text("Male"),

            ),



          ],

        ),

      ),

    );

  }

}
