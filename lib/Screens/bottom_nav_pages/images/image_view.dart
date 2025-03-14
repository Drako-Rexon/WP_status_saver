import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

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
            child: Container(
              height: 60,
              margin: const EdgeInsets.only(right: 120, left: 120, bottom: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () async {
                      await ImageGallerySaver.saveFile(widget.imagePath).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Image saved into your gallery')),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff61FD5E),
                      ),
                      child: const Icon(
                        Icons.download,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () async {
                      Share.shareFiles([widget.imagePath]).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Image has shared')),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff61FD5E),
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
