import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      // Use CacheManager to download and cache the video
      final file = await DefaultCacheManager().getSingleFile(widget.videoUrl);

      // Initialize the video player with the cached file
      _videoController = VideoPlayerController.file(file);
      await _videoController.initialize();

      _videoController.setLooping(true);
      _videoController.setVolume(1.0);

      // Initialize ChewieController only if the widget is still mounted
      if (mounted) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoController,
            autoPlay: false, // Autoplay when the video is loaded
            looping: true,
            allowMuting: true,
            allowPlaybackSpeedChanging: true,
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error initializing video: $e");
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Text(
          "Failed to load video",
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Chewie(controller: _chewieController!);
  }
}