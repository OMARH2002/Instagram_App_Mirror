import 'package:flutter/material.dart';

class CreateUserProfile extends StatefulWidget {
  const CreateUserProfile({super.key});

  @override
  State<CreateUserProfile> createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Edit Profile",style: TextStyle(fontSize: 20,color: Colors.black)),
        centerTitle: true,
        leadingWidth: 80,
        leading: TextButton(onPressed: (){}, child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 16),)),
        actions: [
          TextButton(onPressed: (){}, child: Text('Done',style: TextStyle(
              color: Color(0xFF3897F0),fontSize: 16),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 390,
          height: 167,
          color: Colors.black,
            child: Center(

            child: Column(

            children: [
              SizedBox(height: 10,),
              CircleAvatar(radius: 45,child: Image(image:AssetImage("assets/IMAGES/Profle_Pic.png"))),
              SizedBox(height: 3),
              TextButton(onPressed: (){}, child: Text("Change Profile Photo",style: TextStyle(color: Color(
                  0xFF3897F0),fontFamily: 'SF Pro Text'),))
          ],
        ),
        ),
        ),
      ),
    );
  }
}
