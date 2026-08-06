import 'dart:async';

import 'package:flutter/material.dart';

import 'welcome_screen.dart';



class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();

}



class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    super.initState();


    Timer(

      const Duration(seconds: 2),

      () {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (context)=> const WelcomeScreen(),

          ),

        );

      },

    );

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: const [


            Icon(

              Icons.favorite,

              size:100,

              color:Colors.green,

            ),


            SizedBox(height:20),


            Text(

              "Wellness AI",

              style:TextStyle(

                fontSize:35,

                fontWeight:FontWeight.bold,

              ),

            ),

          ],

        ),

      ),

    );


  }

}