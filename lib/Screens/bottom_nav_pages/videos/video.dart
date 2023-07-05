import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wp_status_saver/Provider/get_status_provider.dart';
import 'package:wp_status_saver/Screens/bottom_nav_pages/videos/video_view.dart';
import 'package:wp_status_saver/Utils/get_thumbnails.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({super.key});

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  bool isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetStatusProvider>(
        builder: (ctx, val, _) {
          if (!isFetched) {
            val.getStatus(".mp4");
            Future.delayed(
                const Duration(milliseconds: 10), () => isFetched = true);
          }
          return Visibility(
            visible: val.isWhatsAppAvailable,
            replacement: const Center(child: Text("No WhatsApp Available...")),
            child: Visibility(
              visible: val.getVideos.isNotEmpty,
              replacement: const Center(child: Text("No Videos Available")),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  children: List.generate(
                    val.getVideos.length,
                    (index) {
                      final data = val.getVideos[index];
                      return FutureBuilder<String>(
                          future: getThumbnail(data.path),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                VideoView(videPath: data.path)),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              FileImage(File(snapshot.data!)),
                                        ),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black54,
                                              blurRadius: 5,
                                              offset: Offset(2, -2))
                                        ],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black54,
                                            blurRadius: 5,
                                            offset: Offset(2, -2)),
                                      ],
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                          });
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
