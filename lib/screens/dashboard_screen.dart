import 'package:flutter/material.dart';
import 'tracking_screen.dart';
import 'ai_chat_screen.dart';
import 'panic_support_screen.dart';


class DashboardScreen extends StatelessWidget {

  const DashboardScreen({super.key});


  @override
  Widget build(BuildContext context){


    return Scaffold(

      appBar:AppBar(

        title:const Text("Wellness Dashboard"),

      ),


      body:Padding(

        padding:const EdgeInsets.all(20),


        child:Column(

          crossAxisAlignment:CrossAxisAlignment.start,

          children:[


            const Text(

              "Welcome 👋",

              style:TextStyle(

                fontSize:32,

                fontWeight:FontWeight.bold,

              ),

            ),


            const SizedBox(height:20),



            dashboardCard(

              context,

              "Daily Tracking",

              Icons.track_changes,

              const TrackingScreen(),

            ),



            dashboardCard(

              context,

              "AI Wellness Companion",

              Icons.smart_toy,

              const AIChatScreen(),

            ),



            dashboardCard(

              context,

              "Emergency Support",

              Icons.health_and_safety,

              const PanicSupportScreen(),

            ),



          ],

        ),

      ),

    );

  }




  Widget dashboardCard(

    BuildContext context,

    String title,

    IconData icon,

    Widget page,

  ){

    return Card(

      child:ListTile(

        leading:Icon(icon),

        title:Text(title),

        trailing:const Icon(Icons.arrow_forward),


        onTap:(){

          Navigator.push(

            context,

            MaterialPageRoute(

              builder:(context)=>page,

            ),

          );

        },

      ),

    );

  }


}