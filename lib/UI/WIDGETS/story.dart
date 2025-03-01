import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_duplicate_app/DATA/story_Model.dart';
import 'package:instagram_duplicate_app/LOGIC/HOMEPAGE/cubit.dart';
import 'package:instagram_duplicate_app/LOGIC/HOMEPAGE/state.dart';

import 'package:instagram_duplicate_app/UI/HOME/Story%20Screen.dart';
import 'package:instagram_duplicate_app/UI/HOME/Story_Upload.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return SizedBox(
            height: 102,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.stories.length + 1, // +1 for "Add Story" button
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const AddStoryButton();
                }
                final story = state.stories[index - 1];
                return StoryCircle(story: story);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class AddStoryButton extends StatelessWidget {
  const AddStoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(35),
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StoryUploadScreen()),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text('Your Story'),
        ],
      ),
    );
  }
}

class StoryCircle extends StatelessWidget {
  final Story story;

  const StoryCircle({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 2),
              borderRadius: BorderRadius.circular(35),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryViewScreen(
                      stories: (context.read<HomeCubit>().state as HomeLoaded).stories,
                      initialIndex: 1,
                      onStoryEnd: () {
                        // Navigate back to the home screen
                        Navigator.pop(
                          context
                        );
                      },
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(story.avatar),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(story.username),
        ],
      ),
    );
  }
}