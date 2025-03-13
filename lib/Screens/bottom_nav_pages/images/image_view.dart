import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
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
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
            image: FileImage(File(widget.imagePath)),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          buttonList.length,
          (index) => FloatingActionButton(
            heroTag: index,
            onPressed: () async {
              switch (index) {
                case 0:
                  await ImageGallerySaver.saveFile(widget.imagePath).then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Image saved into your gallery')),
                    ),
                  );

                  log("Download Image");
                  break;
                case 1:
                  // FlutterNativeApi.printImage(
                  // widget.imagePath!, widget.imagePath!.split('/').last);
                  log("Print Image");
                  break;
                case 2:
                  Share.shareFiles([widget.imagePath]).then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Image has shared')),
                    ),
                  );
                  // ImageShare.shareImage(filePath: widget.imagePath!);
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
