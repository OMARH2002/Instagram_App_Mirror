
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/UI/Messages/chat_Screen.dart';


class AuthService{

  void login(BuildContext context,String email,String password) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  ChatScreen(),
        ),
      );
    } on FirebaseAuthException catch(e){
      Navigator.pop(context);
    }catch(e){
      Navigator.pop(context);
    }
  }


  void register(BuildContext context,String email,String password,String confirmPassword) async {

    try {
      if(password == confirmPassword) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>  ChatScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
    }
  }


  void logout(){
    FirebaseAuth.instance.signOut();
  }
}