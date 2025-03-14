import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wp_status_saver/widgets/bottom_nav_options.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.videoPath});
  final String videoPath;
  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  List<Widget> buttonList = const [Icon(Icons.download), Icon(Icons.share)];
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    log(widget.videoPath);
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(File(widget.videoPath)),
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: ((ctz, errorMsg) {
        return Center(child: Text(errorMsg));
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff61FD5E),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: Chewie(controller: _chewieController!),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavOptions(filePath: widget.videoPath))
        ],
      ),
    );
  }
}
