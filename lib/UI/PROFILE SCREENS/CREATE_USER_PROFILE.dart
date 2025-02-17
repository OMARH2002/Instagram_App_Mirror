import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/divider_widget.dart';

class CreateUserProfile extends StatefulWidget {
  const CreateUserProfile({super.key});

  @override
  State<CreateUserProfile> createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  TextEditingController nameController  = TextEditingController();
  TextEditingController usernameController  = TextEditingController();
  TextEditingController websiteController  = TextEditingController();
  TextEditingController bioController  = TextEditingController();
  TextEditingController emailController  = TextEditingController();
  TextEditingController phoneController  = TextEditingController();
  TextEditingController genderController  = TextEditingController();
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
          TextButton(onPressed: (){



          }, child: Text('Done',style: TextStyle(
              color: Color(0xFF3897F0),fontSize: 16),))
        ],
      ),
      body:  ListView.builder(itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return
              Container(

                child: Center(

                  child: Column(

                    children: [
                      SizedBox(height: 10,),
                      CircleAvatar(radius: 45,
                          child: Image(image: AssetImage(
                              "assets/IMAGES/Profle_Pic.png"))),
                      SizedBox(height: 3),
                      TextButton(onPressed: () {},
                          child: Text("Change Profile Photo",
                            style: TextStyle(color: Color(
                                0xFF3897F0), fontFamily: 'SF Pro Text'),)),


                      Row(
                        children: [
                          SizedBox(width: 9,),
                          Text("Name", style: TextStyle(color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),),
                          SizedBox(width: 50,),
                          Expanded(
                            child: TextFormField(
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
                          SizedBox(width: 9,),
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
                      SizedBox(height: 5,),

                      CustomDivider(),


                      Row(
                        children: [
                          SizedBox(width: 9,),
                          Text("Website", style: TextStyle(
                              color: Colors.black, fontSize: 15),),
                          SizedBox(width: 25,),
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
                      SizedBox(height: 5,),


                      CustomDivider(),


                      Row(
                        children: [
                          SizedBox(width: 9,),
                          Text("Bio", style: TextStyle(
                              color: Colors.black, fontSize: 15),),
                          SizedBox(width: 55,),
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
                      SizedBox(height: 5,),


                      CustomDivider(),

                      Row(

                        children: [
                          TextButton(onPressed: () {},
                              child: Text("Switch to Professional Account",
                                style: TextStyle(
                                    color: Color(0xFF3897F0), fontSize: 15),)),
                        ],
                      ),

                      CustomDivider(),

                      const Row(

                        children: [
                          SizedBox(width: 15,),
                          Text("Private Information",
                            style: TextStyle(
                                color: Colors.black, fontSize: 15),),
                        ],
                      ),
                      const SizedBox(height: 10,),

                      Row(
                        children: [
                          SizedBox(width: 9,),
                          Text("Email", style: TextStyle(
                              color: Colors.black, fontSize: 15),
                          ),

                          const SizedBox(width: 30,),

                          Expanded(
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: "Enter Email",
                                border: InputBorder.none,
                              ),


                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 5,),

                      CustomDivider(),


                      Row(
                        children: [
                          SizedBox(width: 9,),
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
                      SizedBox(height: 5,),

                      CustomDivider(),


                      Row(
                        children: [
                          SizedBox(width: 9,),
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

                    ],
                  ),
                ),
              );


          })
          );
  }
}