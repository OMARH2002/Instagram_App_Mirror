
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/state.dart';
import 'package:instagram_duplicate_app/UI/PROFILE%20SCREENS/CREATE_USER_PROFILE.dart';



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
                  toolbarHeight: 56.h,
                  title: Text(username, style: TextStyle(fontSize: 20.sp)),
                  backgroundColor: Colors.red,
                  actions: [

                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.dark_mode)),
                    IconButton(onPressed: (){}, icon: Image(image: AssetImage("assets/ICONS/Add_Icon.png",),width: 20.w,height: 20.h,)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.black,)),


                  ],// ✅ Dynamic name

                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.w,  // Adjust size for the outer border
                            height: 80.h,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFFC913B9), Color(0xFFF9373F), Color(0xFFFECD00)], // Gradient colors
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.r), // Border thickness
                              child: CircleAvatar(
                                radius: 30.r,
                                // Actual avatar size
                                backgroundImage: AssetImage('assets/IMAGES/profilepic.png'),
                              ),
                            ),
                          ),

                          SizedBox(width: 45.w ,),
                          Column(
                            children: [Text('0'),
                              Text("Posts"),
                            ],

                          ),
                          SizedBox(width: 15.w,),

                          Column(
                            children: [Text('0'),
                              Text("Followers"),
                            ],

                          ),
                          SizedBox(width: 15.w,),
                          Column(
                            children: [Text('0'),
                              Text("Following"),
                            ],
                          ),

                        ],
                      ),
                      SizedBox        (height: 10.h,),
                      Row(

                        children: [
                          SizedBox(width: 10.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 5.h,),
                              Text(category),
                              SizedBox(height: 5.h,),
                              Text(bio),
                              SizedBox(height: 5.h,),
                              Text(website),
                            ],)
                        ],
                      ),
                      SizedBox(height: 15.h,),

                      Row(

                        children: [
                          SizedBox(height: 15.h,width: 25.w,),

                          InkWell(onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateusersProfile(),));

                          },

                            child: Container(
                              width: 270.w,
                              height: 25.h,
                              color: Color(0xFFEFEFEF),
                              child: Center(
                                child: Text("Edit Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),

                          InkWell(onTap: (){

                          },
                            child: Container(
                              width: 38.w,
                              height: 25.h,
                              color: Color(0xFFEFEFEF),
                              child: Icon(Icons.person_add_outlined),),
                          )],

                      ),
                      SizedBox(height: 25.h,),




                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 35.r,
                                  backgroundImage: AssetImage('assets/IMAGES/profilepic.png'),
                                ),
                                Text("Text here"),
                              ],
                            ),
                            SizedBox(width: 5.w),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 35.r,
                                  backgroundImage: AssetImage('assets/IMAGES/profilepic.png'),
                                ),
                                Text("Text here"),
                              ],
                            ),
                            SizedBox(width: 5.w),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 35.r,
                                  backgroundImage: AssetImage('assets/IMAGES/profilepic.png'),
                                ),
                                Text("Text here"),
                              ],
                            ),

                            SizedBox(width: 5.w),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 35.r,
                                  backgroundImage: AssetImage('assets/IMAGES/profilepic.png'),
                                ),
                                Text("Text here"),
                              ],
                            ),
                            SizedBox(width: 5.w),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 35.r,
                                  backgroundImage: AssetImage('assets/IMAGES/profilepic.png'),
                                ),
                                Text("Text here"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,  // Center the icons
                        children: [
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.grid_on_sharp),
                            iconSize: 30.r,
                          ),
                          SizedBox(width: 50),
                          IconButton(
                            onPressed: (){},
                            icon: Image(image: AssetImage("assets/ICONS/play_icon.png"), width: 30.w, height: 30.h),
                          ),
                          SizedBox(width: 50.w),
                          IconButton(
                            onPressed: (){},
                            icon: Image(image: AssetImage("assets/ICONS/mention_icon.png"), width: 30.w, height: 30.h),
                          ),
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
