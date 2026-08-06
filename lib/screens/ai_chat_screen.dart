import 'package:flutter/material.dart';


class AIChatScreen extends StatefulWidget {

  const AIChatScreen({super.key});


  @override
  State<AIChatScreen> createState()=>_AIChatScreenState();

}



class _AIChatScreenState extends State<AIChatScreen>{


  final TextEditingController messageController =
      TextEditingController();



  List<String> messages=[];



  void sendMessage(){


    if(messageController.text.isEmpty){
      return;
    }


    setState((){


      messages.add(

        "You: ${messageController.text}",

      );


      messages.add(

        "AI: I understand. Based on your wellness pattern, let's focus on improving your mental and physical balance today."

      );


      messageController.clear();


    });


  }



  @override
  Widget build(BuildContext context){


    return Scaffold(

      appBar:AppBar(

        title:const Text("AI Wellness Companion"),

      ),



      body:Column(

        children:[


          Expanded(

            child:ListView.builder(

              itemCount:messages.length,

              itemBuilder:(context,index){


                return Padding(

                  padding:const EdgeInsets.all(10),

                  child:Text(

                    messages[index],

                    style:const TextStyle(

                      fontSize:16,

                    ),

                  ),

                );


              },

            ),

          ),



          Padding(

            padding:const EdgeInsets.all(10),


            child:Row(

              children:[


                Expanded(

                  child:TextField(

                    controller:messageController,

                    decoration:const InputDecoration(

                      hintText:"Tell me how you feel",

                      border:OutlineInputBorder(),

                    ),

                  ),

                ),



                IconButton(

                  onPressed:sendMessage,

                  icon:const Icon(Icons.send),

                )


              ],

            ),

          )



        ],

      ),

    );

  }

}