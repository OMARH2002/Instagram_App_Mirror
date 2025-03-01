import 'dart:async';
import 'package:flutter/material.dart';
import 'package:instagram_duplicate_app/DATA/story_Model.dart';

class StoryViewScreen extends StatefulWidget {
  final List<Story> stories;
  final int initialIndex;
  final VoidCallback onStoryEnd;

  const StoryViewScreen({
    super.key,
    required this.stories,
    required this.initialIndex,
    required this.onStoryEnd,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;
  double _progress = 0.0;
  double _dragOffset = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_isDragging) {
        setState(() {
          _progress += 0.01; // Adjust speed here
          if (_progress >= 1.0) {
            _nextStory();
          }
        });
      }
    });
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentIndex++;
        _progress = 0.0;
      });
    } else {
      // Call the callback to handle the end of stories
      widget.onStoryEnd();
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentIndex--;
        _progress = 0.0;
      });
    }
  }

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset = details.primaryDelta!;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset > 50) { // Close if dragged down enough
      Navigator.pop(context);
    } else {
      setState(() {
        _dragOffset = 0.0;
        _isDragging = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            _previousStory();
          } else {
            _nextStory();
          }
        },
        onVerticalDragStart: _onVerticalDragStart,
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(0, _dragOffset),
              child: Opacity(
                opacity: 1 - (_dragOffset / 300).clamp(0.0, 1.0),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.stories.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                      _progress = 0.0;
                    });
                  },
                  itemBuilder: (context, index) {
                    final story = widget.stories[index];
                    return Stack(
                      children: [
                        Image.network(
                          story.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Positioned(
                          top: 40,
                          left: 10,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(story.avatar),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                story.username,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(widget.stories.length, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: LinearProgressIndicator(
                        value: _currentIndex == index ? _progress : 0.0,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _currentIndex == index ? Colors.white : Colors.transparent,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}