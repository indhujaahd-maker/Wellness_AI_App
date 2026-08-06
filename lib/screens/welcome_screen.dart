import 'package:flutter/material.dart';
import 'login_screen.dart';


class WelcomeScreen extends StatelessWidget {

  const WelcomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(30),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [


              const Icon(

                Icons.favorite,

                size:100,

                color:Colors.green,

              ),


              const SizedBox(height:30),



              const Text(

                "Wellness AI",

                style:TextStyle(

                  fontSize:40,

                  fontWeight:FontWeight.bold,

                ),

              ),



              const SizedBox(height:20),



              const Text(

                "Your personal AI wellness companion.\nUnderstand your body and mind.",

                textAlign:TextAlign.center,

                style:TextStyle(

                  fontSize:18,

                  color:Colors.grey,

                ),

              ),



              const SizedBox(height:40),



              ElevatedButton(

                onPressed: (){


                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder:(context)=>const LoginScreen(),

                    ),

                  );


                },

                child:const Text(

                  "Get Started",

                ),

              )


            ],

          ),

        ),

      ),

    );

  }

}