import 'package:flutter/material.dart';


class PanicSupportScreen extends StatelessWidget {


  const PanicSupportScreen({super.key});



  @override
  Widget build(BuildContext context){


    return Scaffold(

      appBar:AppBar(

        title:const Text("Calm Support"),

      ),


      body:Padding(

        padding:const EdgeInsets.all(25),


        child:Column(

          mainAxisAlignment:MainAxisAlignment.center,


          children:[


            const Icon(

              Icons.favorite,

              size:90,

              color:Colors.red,

            ),



            const SizedBox(height:30),



            const Text(

              "Are you feeling overwhelmed?",

              textAlign:TextAlign.center,

              style:TextStyle(

                fontSize:28,

                fontWeight:FontWeight.bold,

              ),

            ),



            const SizedBox(height:20),



            const Text(

              "Try the grounding technique:\n\n"

              "5 things you can see\n"

              "4 things you can touch\n"

              "3 things you can hear\n"

              "2 things you can smell\n"

              "1 thing you can taste",

              textAlign:TextAlign.center,

              style:TextStyle(

                fontSize:18,

              ),

            ),



            const SizedBox(height:30),



            ElevatedButton(

              onPressed:(){},


              child:const Text(

                "I feel better",

              ),

            )


          ],

        ),

      ),

    );

  }

}