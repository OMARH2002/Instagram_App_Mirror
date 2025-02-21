import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 56.h),  // Space where an AppBar would be
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),  // Side padding for better UI
            child: SearchBar(),  // Your search bar
          ),
        ],
      ),
    );
  }
}
