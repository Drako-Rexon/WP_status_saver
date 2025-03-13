import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wp_status_saver/Provider/bottom_nav_provider.dart';
import 'package:wp_status_saver/Screens/bottom_nav_pages/images/image.dart';
import 'package:wp_status_saver/Screens/bottom_nav_pages/videos/video.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = const [ImageHomePage(), VideoHomePage()];
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    // requestPermission();
  }

  void requestPermission() async {
    // final status = await Permission.storage.request();
    final statusmanage = await Permission.manageExternalStorage.request();
    // final statusImage = await Permission.photos;
    // final statusVideo = await Permission.videos;

    // log("image status: $statusImage");
    // log("video status: $statusVideo");
    if (statusmanage.isDenied) {
      await Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (ctx, value, _) => Scaffold(
        body: pages[value.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: value.currentIndex,
          onTap: (val) {
            value.changeIndex(val);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.image), label: "Images"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: "Videos"),
          ],
        ),
      ),
    );
  }
}
