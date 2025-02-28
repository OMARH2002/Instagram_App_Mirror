import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_duplicate_app/LOGIC/HOMEPAGE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/HOMEPAGE/state.dart';
import 'package:instagram_duplicate_app/UI/HOME/Post_Upload.dart';
import 'package:instagram_duplicate_app/UI/HOME/Story_Upload.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/post.dart';
import 'package:instagram_duplicate_app/UI/WIDGETS/story.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56.h,
        title: Image(image: AssetImage('assets/IMAGES/IG_Logo.png'),width:104.w  ,height:30.h,),

        backgroundColor: Colors.red,
        actions: [

          IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/ICONS/Favorite_Icon.png"),width: 24.w,)),
          IconButton(onPressed: (){}, icon:Image(image: AssetImage("assets/ICONS/Chat_Icon.png",),width: 24.w)),
          IconButton(onPressed: () => _showUploadOptions(context), icon:Image(image: AssetImage("assets/ICONS/Add_Icon.png"),width: 24.w  ))
        ],

      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) return const Center(child: CircularProgressIndicator());
          if (state is HomeError) return Center(child: Text(state.message));
          if (state is HomeLoaded) {
            return ListView(
              children: [
                const StoryWidget(),
                ...state.posts.map((post) => PostWidget(post: post)),
              ],
            );
          }
          return const Center(child: Text('No posts available'));
        },
      ),
    );
  }

  void _showUploadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Create Post'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const PostUploadScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add), // Add appropriate icon
            title: const Text('Add Story'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                  builder: (_) => const StoryUploadScreen()));
            },
          ),
        ],
      ),
    );
  }
}