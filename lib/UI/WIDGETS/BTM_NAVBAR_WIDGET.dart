import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/UI/PROFILE%20SCREENS/PROFILE_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/SCREENS/HOME_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/SCREENS/REELS_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/SCREENS/SEARCH_SCREEN.dart';
import 'package:instagram_duplicate_app/UI/SCREENS/SHOPPING_SCREEN.dart';

class Bottombar extends StatefulWidget {
  final int initialIndex;

  const Bottombar({super.key, this.initialIndex = 0}); // Default is Home

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  late int _selectedindex;

  @override
  void initState() {
    super.initState();
    _selectedindex = widget.initialIndex; // Set starting tab
  }

  @override
  Widget build(BuildContext context) {
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.search_sharp), label: "SEARCH"),
          BottomNavigationBarItem(icon: Image(image: AssetImage('assets/ICONS/Reels_Icon.png')), label: "REELS"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "SHOPPING"),
          BottomNavigationBarItem(
              icon: CircleAvatar(radius: 15, backgroundImage: AssetImage("assets/IMAGES/profilepic.png")),
              backgroundColor: Colors.transparent,
              label: "PROFILE"
          ),
        ],
      ),
    );
  }
}
