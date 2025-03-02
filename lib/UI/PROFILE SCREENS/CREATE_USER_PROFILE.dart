import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_duplicate_app/DATA/Create_user_profile_MODEL.dart';
import 'package:instagram_duplicate_app/LOGIC/AvatarChange/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/AvatarChange/state.dart';
import 'package:instagram_duplicate_app/LOGIC/CREEATE_USER_PROFILE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/CREEATE_USER_PROFILE/state.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/BTM_NAVBAR_WIDGET.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/divider_widget.dart';

class CreateusersProfile extends StatefulWidget {
  const CreateusersProfile({super.key});

  @override
  State<CreateusersProfile> createState() => _CreateusersProfileState();
}

class _CreateusersProfileState extends State<CreateusersProfile> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateuserprofileCubit()..fetchUserProfile(),
        child: BlocConsumer<CreateuserprofileCubit, CreateuserprofileStates>(
            listener: (context, state) {
              if (state is CreateuserprofileSuccesState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User Data updated Successfully')));
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Bottombar(initialIndex: 4,)));
              } else if (state is CreateuserprofileErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              } else if (state is CreateuserprofileLoadedState) {
                nameController.text = state.userProfile.name;
                usernameController.text = state.userProfile.username;
                websiteController.text = state.userProfile.website;
                bioController.text = state.userProfile.bio;
                emailController.text = state.userProfile.email;
                phoneController.text = state.userProfile.phone;
                genderController.text = state.userProfile.gender;
                categoryController.text = state.userProfile.category;
              }
            }, builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: Text("Create Profile",
                    style: TextStyle(fontSize: 20.sp, color: Colors.black)),
                centerTitle: true,
                leadingWidth: 80,
                leading: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bottombar(initialIndex: 4)));
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
                actions: [
                  TextButton(
                      onPressed: () {
                        context.read<CreateuserprofileCubit>().createProfile(
                          CreateUserProfileModel(
                              userID: FirebaseAuth.instance.currentUser!.uid,
                              name: nameController.text,
                              username: usernameController.text,
                              website: websiteController.text,
                              bio: bioController.text,
                              email: FirebaseAuth.instance.currentUser!.email!,
                              gender: genderController.text,
                              phone: phoneController.text,
                              category: categoryController.text),
                        );
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                            color: Color(0xFF3897F0), fontSize: 16.sp),
                      ))
                ],
              ),
              body: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Form(
                        key: formkey,
                        child: Container(
                            child: Center(
                                child: Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      BlocProvider(
                                          create: (context) =>
                                          AvatarCubit()..loadAvatar(),
                                          child: BlocConsumer<AvatarCubit, AvatarState>(
                                              listener: (context, state) {
                                                if (state is AvatarError) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(state.message),
                                                  ));
                                                }
                                              },
                                              builder: (context, state) {
                                                Widget? avatarChild;
                                                ImageProvider? backgroundImage;

                                                if (state is AvatarPicked) {
                                                  backgroundImage = FileImage(state.file);
                                                } else if (state is AvatarUploaded) {
                                                  backgroundImage =
                                                      NetworkImage(state.imageUrl);
                                                } else if (state is AvatarUploading) {
                                                  avatarChild = CircularProgressIndicator();
                                                } else {
                                                  avatarChild =
                                                      Icon(Icons.person, size: 50.r);
                                                }

                                                return Column(
                                                  children: [
                                                    Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 45,
                                                          backgroundImage: backgroundImage,
                                                          child: backgroundImage == null
                                                              ? avatarChild
                                                              : null,
                                                        ),
                                                        if (state is AvatarUploading)
                                                          CircularProgressIndicator(),
                                                      ],
                                                    ),
                                                    SizedBox(height: 3.h),
                                                    TextButton(
                                                        onPressed: () {
                                                          context
                                                              .read<AvatarCubit>()
                                                              .pickImage();
                                                        },
                                                        child: Text(
                                                            "Change Profile Photo",
                                                            style: TextStyle(
                                                                color: Color(0xFF3897F0),
                                                                fontFamily: 'SF Pro Text'),
                                          )
                                      ),

                                  // data under avatar
                                  Row(
                                    children: [
                                      SizedBox(width: 9.w ,),
                                      Text("Name",
                                        style: TextStyle(color: Colors.black,
                                          fontSize: 15,
                                        ),),
                                      SizedBox(width: 50.w  ,),
                                      Expanded(

                                        child:
                                        TextFormField(
                                          controller: nameController,
                                          decoration: InputDecoration(

                                              hintText: "Enter Name",
                                              border: InputBorder.none
                                          ),


                                        ),
                                      ),

                                    ],
                                  ),

                                  CustomDivider(),

                                  Row(
                                    children: [
                                      SizedBox(width: 9.w,),
                                      Text("UserName", style: TextStyle(
                                          color: Colors.black, fontSize: 15),),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: TextFormField(
                                          controller: usernameController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            hintText: "Enter UserName",
                                            border: InputBorder.none,
                                          ),


                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 5.h,),

                                  CustomDivider(),


                                  Row(
                                    children: [
                                      SizedBox(width: 9.w ,),
                                      Text("Website", style: TextStyle(
                                          color: Colors.black, fontSize: 15.r),),
                                      SizedBox(width: 25.w,),
                                      Expanded(
                                        child: TextFormField(
                                          controller: websiteController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            hintText: "Enter Website",
                                            border: InputBorder.none,
                                          ),


                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 5.h,),


                                  CustomDivider(),


                                  Row(
                                    children: [
                                      SizedBox(width: 9.w,),
                                      Text("Bio", style: TextStyle(
                                          color: Colors.black, fontSize: 15.r),),
                                      SizedBox(width: 55.w,),
                                      Expanded(
                                        child: TextFormField(
                                          controller: bioController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            hintText: "Enter Bio",
                                            border: InputBorder.none,
                                          ),


                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 5.h,),


                                  CustomDivider(),

                                  Row(

                                    children: [
                                      TextButton(onPressed: () {},
                                          child: Text(
                                            "Switch to Professional Account",
                                            style: TextStyle(
                                                color: Color(0xFF3897F0),
                                                fontSize: 15.r),)),
                                    ],
                                  ),

                                  CustomDivider(),

                                   Row(

                                    children: [
                                      SizedBox(width: 15.w,),
                                      Text("Private Information",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.r),),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),

                                  Row(
                                    children: [
                                      SizedBox(width: 9.w,),
                                      Text("Email", style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      ),

                                      SizedBox(width: 30.w,),

                                      Expanded(
                                        child: TextFormField(
                                          controller: emailController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            enabled: false,
                                            hintText: "Enter Email",
                                            border: InputBorder.none,
                                          ),


                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 5.h,),

                                  CustomDivider(),


                                  Row(
                                    children: [
                                      SizedBox(width: 9.w,),
                                      Text("Phone", style: TextStyle(
                                          color: Colors.black, fontSize: 15),),
                                      SizedBox(width: 25,),
                                      Expanded(
                                        child: TextFormField(
                                          controller: phoneController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            hintText: "Enter Phone Number",
                                            border: InputBorder.none,
                                          ),


                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 5.h,),

                                  CustomDivider(),


                                  Row(
                                    children: [
                                      SizedBox(width: 9.w,),
                                      Text("Gender", style: TextStyle(
                                          color: Colors.black, fontSize: 15),),
                                      SizedBox(width: 25,),
                                      Expanded(
                                        child: TextFormField(
                                          controller: genderController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            hintText: "Enter Gender",
                                            border: InputBorder.none,
                                          ),


                                        ),
                                      ),

                                    ],
                                  ),
                                  CustomDivider(),

                                  Row(
                                    children: [
                                      SizedBox(width: 9.w ,),
                                      Text("Category", style: TextStyle(
                                          color: Colors.black, fontSize: 15.r),),
                                      SizedBox(width: 25,),
                                      Expanded(
                                        child: TextFormField(
                                          controller: categoryController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            hintText: "Enter Category",
                                            border: InputBorder.none,
                                          ),


                                        ),
                                      ),

                                    ],
                                  ),

                                  CustomDivider()


                                ],


                              );
                            }
                        )
                        )])
              )
                        )
                        );
            })
                            );



                  }


        )
    );
  }
  }