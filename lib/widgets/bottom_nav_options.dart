import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

class BottomNavOptions extends StatelessWidget {
  const BottomNavOptions({
    super.key,
    required this.filePath,
  });

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              log(filePath);

              await ImageGallerySaver.saveFile(filePath).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File saved into your gallery')),
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
              Share.shareXFiles([XFile(filePath)]).then(
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
    );
  }
}
