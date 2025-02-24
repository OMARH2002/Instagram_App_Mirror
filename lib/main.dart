import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_duplicate_app/UI/SPLASH_SCREEN/SPLASH_SCREEN_ICON.dart';

import 'package:instagram_duplicate_app/UI/WELCOME%20SCREENS/LOGIN_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/BTM_NAVBAR_WIDGET.dart';






void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690), // Base size (adjust if needed)
        minTextAdapt: true,
        splitScreenMode: true,
     builder: (
       context,child) {
        return MaterialApp(
          title: 'Instagram App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreenIcon()

        );
      }
    );

  }
}
