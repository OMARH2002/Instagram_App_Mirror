import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Image(image: AssetImage('assets/IMAGES/IG_Logo.png'),width:104,height:30,),

       backgroundColor: Colors.red,
       actions: [

         IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/ICONS/Favorite_Icon.png"),width: 24,)),
         IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/ICONS/Chat_Icon.png",),width: 24)),
         IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/ICONS/Add_Icon.png"),width: 24))
       ],

     ),



    );
  }
}
