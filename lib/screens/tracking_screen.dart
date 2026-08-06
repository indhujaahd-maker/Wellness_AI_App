import 'package:flutter/material.dart';


class TrackingScreen extends StatefulWidget {

  const TrackingScreen({super.key});


  @override
  State<TrackingScreen> createState()=>_TrackingScreenState();

}



class _TrackingScreenState extends State<TrackingScreen>{


  bool water=false;
  bool exercise=false;
  bool meditation=false;
  bool sleep=false;



  @override
  Widget build(BuildContext context){


    return Scaffold(

      appBar:AppBar(

        title:const Text("Daily Wellness Tracking"),

      ),


      body:Padding(

        padding:const EdgeInsets.all(20),


        child:Column(

          children:[


            CheckboxListTile(

              title:const Text("Drank enough water"),

              value:water,

              onChanged:(value){

                setState((){

                  water=value!;

                });

              },

            ),



            CheckboxListTile(

              title:const Text("Exercise completed"),

              value:exercise,

              onChanged:(value){

                setState((){

                  exercise=value!;

                });

              },

            ),



            CheckboxListTile(

              title:const Text("Meditation completed"),

              value:meditation,

              onChanged:(value){

                setState((){

                  meditation=value!;

                });

              },

            ),



            CheckboxListTile(

              title:const Text("Good sleep"),

              value:sleep,

              onChanged:(value){

                setState((){

                  sleep=value!;

                });

              },

            ),



            const SizedBox(height:30),



            const Text(

              "Your wellness habits are tracked locally.",

              style:TextStyle(

                color:Colors.grey,

              ),

            )


          ],

        ),

      ),

    );

  }

}