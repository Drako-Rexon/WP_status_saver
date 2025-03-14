import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wp_status_saver/widgets/bottom_nav_options.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List<Widget> buttonList = const [
    Icon(Icons.download),
    Icon(Icons.print),
    Icon(Icons.share),
  ];

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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: FileImage(File(widget.imagePath)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavOptions(filePath: widget.imagePath),
          )
        ],
      ),
    );
  }
}
