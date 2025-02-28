import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/state.dart';
import 'package:instagram_duplicate_app/UI/HOME/HOME_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/PROFILE%20SCREENS/PROFILE_SCREEN.dart';

import 'package:instagram_duplicate_app/UI/Search/SEARCH_SCREEN.dart';


import 'package:instagram_duplicate_app/UI/reels_screens/REELS_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/shopping/SHOPPING_SCREEN.dart';

class Bottombar extends StatefulWidget {
  final int initialIndex;

  const Bottombar({super.key, this.initialIndex = 0}); // Default is Home

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  String avatar = "https://via.placeholder.com/150";
  late int _selectedindex;

  @override
  void initState() {
    super.initState();
    _selectedindex = widget.initialIndex; // Set starting tab
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserPageCubit()..fetchUserProfile(),
        child: BlocConsumer<UserPageCubit,UserPageStates>
        (listener: (context, state) {
      if (state is UserPageSuccessState) {
        setState(() {
          avatar = state.avatar;

        });
      }
    },
    builder: (context, state) {
      return Scaffold(
        body: IndexedStack(
          index: _selectedindex,
          children: [
            HomeScreen(),
            SearchScreen(),
            ReelsScreen(),
            ShoppingScreen(),
            ProfileScreen()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedindex,
          onTap: (index) {
            setState(() {
              _selectedindex = index;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "HOME"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search_sharp), label: "SEARCH"),
            const BottomNavigationBarItem(
                icon: Image(image: AssetImage('assets/ICONS/Reels_Icon.png')),
                label: "REELS"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: "SHOPPING"),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                    radius: 15,
                  backgroundImage: avatar.isNotEmpty
                      ? NetworkImage(avatar)
                      : AssetImage('assets/IMAGES/Avatar_default.png') as ImageProvider,
                  backgroundColor: Colors.transparent,
                ),
                label: "PROFILE"
            ),
          ],
        ),
      );
    }
    )
    );
  }
}
