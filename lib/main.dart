import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:instagram_duplicate_app/LOGIC/HOMEPAGE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/REELS/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/SEARCH/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/SHOPPING/cubit.dart';

import 'package:instagram_duplicate_app/themes/appthemes.dart';
import 'package:provider/provider.dart';
import 'package:instagram_duplicate_app/UI/SPLASH_SCREEN/SPLASH_SCREEN_ICON.dart';

import 'package:instagram_duplicate_app/themes/themes.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Base size (adjust if needed)
      minTextAdapt: true,
      splitScreenMode: true,
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(), // Provide the ThemeNotifier
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeCubit()),
            BlocProvider(create: (context) => ReelCubit()),
            BlocProvider(create: (context) => ShoppingCubit()),
            BlocProvider(create: (context) => SearchCubit()),
          ],
          child: Consumer<ThemeNotifier>(
            builder: (context, notifier, child) {
              return MaterialApp(
                title: 'Instagram Duplicate App',
                theme: AppThemes.lightTheme, // Use your custom light theme
                darkTheme: AppThemes.darkTheme, // Use your custom dark theme
                themeMode: notifier.themeMode, // Dynamic theme mode
                debugShowCheckedModeBanner: false,
                home: const SplashScreenIcon(),
              );
            },
          ),
        ),
      ),
    );
  }
}
