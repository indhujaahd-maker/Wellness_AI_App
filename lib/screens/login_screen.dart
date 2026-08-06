import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'dashboard_screen.dart';


class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar:AppBar(

        title:const Text("Login"),

      ),


      body:Padding(

        padding:const EdgeInsets.all(25),


        child:Column(

          mainAxisAlignment:MainAxisAlignment.center,


          children:[


            const Text(

              "Welcome Back",

              style:TextStyle(

                fontSize:35,

                fontWeight:FontWeight.bold,

              ),

            ),


            const SizedBox(height:30),



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

              child:const Text("Login"),

            ),



            TextButton(

              onPressed:(){

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>const RegisterScreen(),

                  ),

                );

              },

              child:const Text(

                "Create new account",

              ),

            )


          ],

        ),

      ),

    );

  }

}