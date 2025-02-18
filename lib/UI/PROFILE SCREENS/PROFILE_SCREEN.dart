import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/state.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/divider_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Enter Name..."; // Default text before fetching
  String username = "Loading..."; // Default text before fetching
  String category = "Category/Genre text"; // Default text before fetching
  String bio = "biography"; // Default text before fetching
  String website = "Link Goes Here"; // Default text before fetching


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserPageCubit()..fetchUserProfile(),
      child: BlocConsumer<UserPageCubit,UserPageStates>
        (listener: (context, state) {
          if (state is UserPageSuccessState) {
            setState(() {
              name  = state.name;
              username = state.username;
             category = state.category;
              bio = state.bio;
              website = state.website;

            });
          }
        },
    builder: (context, state){
      return Scaffold(
        appBar: AppBar(
          title: Text(username, style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.red,
          actions: [
            IconButton(onPressed: (){}, icon: Image(image: AssetImage("assets/ICONS/Add_Icon.png",),width: 20,height: 20,)),
            IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.black,)),


          ],// ✅ Dynamic name

        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/IMAGES/profilepic.png'),
                  ),

                  SizedBox(width: 45,),
                  Column(
                    children: [Text('0'),
                      Text("Posts"),
                    ],

                  ),
                  SizedBox(width: 15,),

                  Column(
                    children: [Text('0'),
                      Text("Followers"),
                    ],

                  ),
                  SizedBox(width: 15,),
                  Column(
                    children: [Text('0'),
                      Text("Following"),
                    ],
                  ),

                ],
              ),
              CustomDivider(),
              CustomDivider(),

              Row(

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(name),
                    SizedBox(height: 5,),
                    Text(category),
                    SizedBox(height: 5,),
                    Text(bio),
                    SizedBox(height: 5,),
                    Text(website),
                  ],)
                ],
              )
            ],
          ),
        )
      );

    }
    ),
    );
    }
  }


