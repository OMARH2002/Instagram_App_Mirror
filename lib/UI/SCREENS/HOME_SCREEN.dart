import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




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
       toolbarHeight: 56.h,
       title: Image(image: AssetImage('assets/IMAGES/IG_Logo.png'),width:104.w  ,height:30.h,),

       backgroundColor: Colors.red,
       actions: [

         IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/ICONS/Favorite_Icon.png"),width: 24.w,)),
         IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/ICONS/Chat_Icon.png",),width: 24.w)),
         IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/ICONS/Add_Icon.png"),width: 24.w  ))
       ],

     ),





    );
  }
}
