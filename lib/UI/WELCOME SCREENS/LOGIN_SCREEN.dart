import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/LOGIC/LOGIN/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/LOGIN/state.dart';

import 'package:instagram_duplicate_app/UI/WELCOME%20SCREENS/REGISTER_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/BTM_NAVBAR_WIDGET.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController =TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>LoginCubit(FirebaseAuth.instance),

      child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context,state){
            if(state is LoginSucessState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Data is Correct ")));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Bottombar()));
            }else if (state is LoginErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },

          builder: (context,state){
          return Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
          
            body: Padding(
              padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
          
                     Image(image:AssetImage("assets/IMAGES/IG_Logo.png",),width: 244,height: 68),
                      SizedBox(height: 15,),
          
          
                      Form(key: formkey,
                      child:
                          //Email Text Field
                        Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration:
                              InputDecoration(
                                fillColor: Color(0xFFD9D9D9),
                                filled: true,
          
                                label: Text("EMAIL"),
                                labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                                borderSide:BorderSide(color:Colors.transparent) ),
          
                              ),
          
                            ),
                        SizedBox(height: 15,),
                        //PASSWORD TEXT FIELD
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
          
                            fillColor: Color(0xFFD9D9D9),
                            filled: true,
          
          
                            label: Text("PASSWORD"),
                            labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),
                                borderSide:BorderSide(color:Colors.transparent) ),
          
                          ),
                        )
                          ],
                        ),
                      ),
          
          
          
                      SizedBox(height: 15,),

                      // Login Button with Loading Spinner
                      InkWell(
                        onTap: () {
                          if (formkey.currentState?.validate() ?? false) {
                            final email = emailController.text;
                            final password = passwordController.text;
                            context.read<LoginCubit>().Login(email, password);
                          }
                        },
                        child: Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: state is LoginLoadingState
                                ? CircularProgressIndicator(
                              color: Colors.white,
                            ) // Show loading spinner
                                : Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ), // Show normal text when not loading
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have An Account?"),
                            SizedBox(width: 5),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
          );
          },
      ),
    );
  }
}
