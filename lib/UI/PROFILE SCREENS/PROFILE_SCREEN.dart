import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Loading..."; // Default text before fetching

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserPageCubit()..fetchUserProfile(),
      child: BlocConsumer<UserPageCubit,UserPageStates>
        (listener: (context, state) {
          if (state is UserPageSuccessState) {
            setState(() {
              name = state.name; // ✅ Update AppBar title with user name
            });
          }
        },
    builder: (context, state){
      return Scaffold(
        appBar: AppBar(
          title: Text(name, style: TextStyle(fontSize: 20)), // ✅ Dynamic name

        ),
        body: Center(child: Text("Welcome, $name!")),
      );

    }
    ),
    );
    }
  }


