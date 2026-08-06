import 'package:flutter/material.dart';
import 'dashboard_screen.dart';


class RegisterScreen extends StatelessWidget {

  const RegisterScreen({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar:AppBar(

        title:const Text("Register"),

      ),


      body:Padding(

        padding:const EdgeInsets.all(25),


        child:Column(

          mainAxisAlignment:MainAxisAlignment.center,


          children:[


            const Text(

              "Create Account",

              style:TextStyle(

                fontSize:35,

                fontWeight:FontWeight.bold,

              ),

            ),



            const SizedBox(height:30),



            const TextField(

              decoration:InputDecoration(

                labelText:"Name",

                border:OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:20),



            const TextField(

              decoration:InputDecoration(

                labelText:"Email",

                border:OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:20),



            const TextField(

              obscureText:true,

              decoration:InputDecoration(

                labelText:"Password",

                border:OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:30),



            ElevatedButton(

              onPressed:(){

                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>const DashboardScreen(),

                  ),

                );

              },

              child:const Text("Register"),

            )

          ],

        ),

      ),

    );

  }

}