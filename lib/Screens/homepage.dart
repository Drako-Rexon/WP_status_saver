import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
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
  final List<Widget> _pages = const [ImageHomePage(), VideoHomePage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<BottomNavProvider>(
        builder: (BuildContext ctx, BottomNavProvider value, Widget? _) =>
            Scaffold(
          body: _pages[value.currentIndex],
          bottomNavigationBar: Container(
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
                  onTap: () => value.changeIndex(0),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value.currentIndex == 0
                          ? const Color(0xff61FD5E)
                          : Colors.black,
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      color:
                          value.currentIndex == 0 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () => value.changeIndex(1),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value.currentIndex == 1
                          ? const Color(0xff61FD5E)
                          : Colors.black,
                    ),
                    child: Icon(
                      Icons.video_call,
                      color:
                          value.currentIndex == 1 ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
