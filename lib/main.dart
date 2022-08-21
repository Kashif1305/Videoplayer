import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      'asset/video1.mp4',
    );

   _initializeVideoPlayerFuture =_controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
      ),
      
      body: 
       VideoPlayer(_controller),
      // AspectRatio(
      //         aspectRatio: _controller.value.aspectRatio,
      //         child: VideoPlayer(_controller),
      //       ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            
            if (_controller.value.isPlaying) 
            {
              _controller.pause();
            } else 
            {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}