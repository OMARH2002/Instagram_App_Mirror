import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/USER_PROFILE_PAGE/state.dart';
import 'package:instagram_duplicate_app/UI/PROFILE%20SCREENS/CREATE_USER_PROFILE.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/User%20Images.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/signout.dart';
import 'package:instagram_duplicate_app/themes/themes.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  String name = "Enter Name..."; // Default text before fetching
  String username = "Loading..."; // Default text before fetching
  String category = "Category/Genre text"; // Default text before fetching
  String bio = "biography"; // Default text before fetching
  String website = "Link Goes Here";
  String avatar = "https://via.placeholder.com/150"; // Default text before fetching

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Initialize the TabController
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserPageCubit()..fetchUserProfile(),
      child: BlocConsumer<UserPageCubit, UserPageStates>(
        listener: (context, state) {
          if (state is UserPageSuccessState) {
            setState(() {
              name = state.name;
              username = state.username;
              category = state.category;
              bio = state.bio;
              website = state.website;
              avatar = state.avatar;
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 56.h,
              title: Text(username, style: TextStyle(fontSize: 20.sp)),
              backgroundColor: Colors.red,
              actions: [
                IconButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
                  },
                  icon: Icon(Icons.dark_mode),
                ),
                IconButton(
                  onPressed: () {
                    showSignOutMenu(context); // Call the function from the separate file
                  },
                  icon: Icon(Icons.signpost, color: Colors.black),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.w, // Adjust size for the outer border
                        height: 80.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFFC913B9), Color(0xFFF9373F), Color(0xFFFECD00)], // Gradient colors
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.r), // Border thickness
                          child: CircleAvatar(
                            radius: 30.r,
                            // Actual avatar size
                            backgroundImage: NetworkImage(avatar),
                          ),
                        ),
                      ),
                      SizedBox(width: 45.w),
                      Column(
                        children: [
                          Text('0'),
                          Text("Posts"),
                        ],
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        children: [
                          Text('0'),
                          Text("Followers"),
                        ],
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        children: [
                          Text('0'),
                          Text("Following"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 5.h),
                          Text(category),
                          SizedBox(height: 5.h),
                          Text(bio),
                          SizedBox(height: 5.h),
                          Text(website),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      SizedBox(height: 15.h, width: 25.w),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateusersProfile(),
                            ),
                          );
                        },
                        child: Container(
                          width: 270.w,
                          height: 25.h,
                          color: Color(0xFFEFEFEF),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 38.w,
                          height: 25.h,
                          color: Color(0xFFEFEFEF),
                          child: Icon(Icons.person_add_outlined),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),
                  // Add TabBar
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(icon: Icon(Icons.grid_on_sharp)), // Grid view
                      Tab(icon: Icon(Icons.play_arrow)), // Play view
                      Tab(icon: Icon(Icons.alternate_email)), // Mention view
                    ],
                  ),
                  // Add TabBarView
                  SizedBox(
                    height: 400.h, // Adjust height as needed
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Grid view (UserProfileImages)
                        UserProfileImages(),

                        // Play view (Placeholder)
                        Center(child: Text("Play View")),

                        // Mention view (Placeholder)
                        Center(child: Text("Mention View")),
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