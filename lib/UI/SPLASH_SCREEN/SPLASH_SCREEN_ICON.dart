import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:instagram_duplicate_app/UI/WELCOME%20SCREENS/LOGIN_SCREEN.dart';

class SplashScreenIcon extends StatefulWidget {
  const SplashScreenIcon({super.key});

  @override
  State<SplashScreenIcon> createState() => _SplashScreenIconState();
}

class _SplashScreenIconState extends State<SplashScreenIcon> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 6), () {
        if (mounted) { // Ensure the widget is still in the tree
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: Image(image: const AssetImage('assets/ICONS/Instagram_Icon.png'),width: 150.w,height: 150.h,),
        ),

    );
  }
}