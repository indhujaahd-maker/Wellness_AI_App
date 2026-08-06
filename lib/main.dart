import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';


void main() {

  runApp(const WellnessApp());

}



class WellnessApp extends StatelessWidget {

  const WellnessApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Wellness AI",

      theme: ThemeData(

        primarySwatch: Colors.green,

      ),

      home: const SplashScreen(),

    );

  }

}