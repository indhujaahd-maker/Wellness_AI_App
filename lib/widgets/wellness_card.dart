import 'package:flutter/material.dart';



class WellnessCard extends StatelessWidget {


  final String title;

  final String subtitle;

  final IconData icon;

  final Color color;



  const WellnessCard({

    super.key,

    required this.title,

    required this.subtitle,

    required this.icon,

    required this.color,

  });



  @override
  Widget build(BuildContext context) {


    return Card(

      elevation:3,


      child:Padding(

        padding:const EdgeInsets.all(15),


        child:Row(

          children:[


            CircleAvatar(

              radius:25,

              backgroundColor:color,

              child:Icon(

                icon,

                color:Colors.white,

              ),

            ),



            const SizedBox(width:20),



            Expanded(

              child:Column(

                crossAxisAlignment:CrossAxisAlignment.start,


                children:[


                  Text(

                    title,

                    style:const TextStyle(

                      fontSize:20,

                      fontWeight:FontWeight.bold,

                    ),

                  ),



                  const SizedBox(height:5),



                  Text(

                    subtitle,

                    style:const TextStyle(

                      color:Colors.grey,

                    ),

                  )



                ],

              ),

            )


          ],

        ),

      ),

    );

  }

}