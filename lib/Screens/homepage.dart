import 'package:flutter/material.dart';
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
