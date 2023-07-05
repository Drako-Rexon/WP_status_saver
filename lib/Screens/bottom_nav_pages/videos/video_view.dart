import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, this.videPath});
  final String? videPath;
  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  List<Widget> buttonList = const [Icon(Icons.download), Icon(Icons.share)];
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(File(widget.videPath!)),
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
      body: Chewie(controller: _chewieController!),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          buttonList.length,
          (index) => FloatingActionButton(
            heroTag: index,
            onPressed: () async {
              switch (index) {
                case 0:
                  await ImageGallerySaver.saveFile(widget.videPath!).then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Video saved into your gallery')),
                    ),
                  );
                  log("Download Image");
                  break;
                case 1:
                  Share.shareFiles([widget.videPath!]).then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('The file has Shared')),
                    ),
                  );
                  log("Share Image");
                  break;
              }
            },
            child: buttonList[index],
          ),
        ),
      ),
    );
  }
}
