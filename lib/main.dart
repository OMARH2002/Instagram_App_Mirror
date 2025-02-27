import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_duplicate_app/LOGIC/REELS/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/SHOPPING/cubit.dart';



import 'package:instagram_duplicate_app/UI/WELCOME%20SCREENS/LOGIN_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/shopping/uplaod%20screen.dart';
import 'package:instagram_duplicate_app/themes/themes.dart';
import 'package:provider/provider.dart';







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

    child:
    MultiBlocProvider(
      providers: [



        BlocProvider(create: (context) => ReelCubit()),
        BlocProvider(create: (context) => ShoppingCubit()),

      ],

      child: ChangeNotifierProvider(
        create: (_) => ThemeManager(), // Provide ThemeManager
        child: Consumer<ThemeManager>(

          builder: (context, themeManager, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: themeManager.isDarkMode
                  ? ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Colors.black,
                appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
              )
                  : ThemeData.light(), // Light Theme
              debugShowCheckedModeBanner: false,

              home: LoginScreen(),
            );
          },
        ),
      ),
    ));
  }
}
