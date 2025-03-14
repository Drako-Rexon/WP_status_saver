import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:wp_status_saver/Provider/get_status_provider.dart';
import 'package:wp_status_saver/Screens/bottom_nav_pages/videos/video_view.dart';
import 'package:wp_status_saver/Utils/get_thumbnails.dart';
import 'package:wp_status_saver/helper/ad_helper.dart';
import 'package:wp_status_saver/widgets/download_button.dart';

class VideoHomePage extends StatefulWidget {
  const VideoHomePage({super.key});

  @override
  State<VideoHomePage> createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  bool isFetched = false;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          if (mounted) {
            setState(() {
              _bannerAd = ad as BannerAd;
            });
          }
        },
        onAdFailedToLoad: (ad, error) {
          log("Failed to load the banner");
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "WhatStatus Saver",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff61FD5E),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          _bannerAd != null
              ? SizedBox(
                  height: _bannerAd!.size.height.toDouble(),
                  width: _bannerAd!.size.width.toDouble(),
                  child: AdWidget(
                    ad: _bannerAd!,
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: Stack(
              children: [
                Consumer<GetStatusProvider>(
                  builder: (ctx, val, _) {
                    if (!isFetched) {
                      val.getStatus(".mp4");
                      Future.delayed(const Duration(milliseconds: 10),
                          () => isFetched = true);
                    }
                    return Visibility(
                      visible: val.isWhatsAppAvailable,
                      replacement:
                          const Center(child: Text("No WhatsApp Available...")),
                      child: Visibility(
                        visible: val.getVideos.isNotEmpty,
                        replacement:
                            const Center(child: Text("No Videos Available")),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                    builder: (_) => VideoView(
                                                        videPath: data.path)),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(
                                                          File(snapshot.data!)),
                                                    ),
                                                    color: Colors.white,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.black54,
                                                          blurRadius: 5,
                                                          offset: Offset(2, -2))
                                                    ],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        DownloadButton(
                                                          function: () async {
                                                            await ImageGallerySaver
                                                                    .saveFile(
                                                                        data.path)
                                                                .then(
                                                              (value) => Fluttertoast.showToast(
                                                                  msg:
                                                                      "The file has been saved into your gallery",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .SNACKBAR,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xff61FD5E),
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  fontSize:
                                                                      16.0),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black54,
                                                    blurRadius: 5,
                                                    offset: Offset(2, -2)),
                                              ],
                                            ),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
