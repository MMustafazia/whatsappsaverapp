import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappsaver/provider/bottom_nav_provider.dart';
import 'package:whatsappsaver/whatsappsaver/bottomNavPage/images/image.dart';
import 'package:whatsappsaver/whatsappsaver/bottomNavPage/images/imagew.dart';
import 'package:whatsappsaver/whatsappsaver/bottomNavPage/videos/video.dart';
import 'package:whatsappsaver/whatsappsaver/bottomNavPage/videos/videow.dart';

class HomeW extends StatefulWidget {
  const HomeW({super.key});

  @override
  State<HomeW> createState() => _HomeWState();
}

class _HomeWState extends State<HomeW> {
  List<Widget> pages = const [ImageHome2Page(), VideoHome2Page()];
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(builder: (context, nav, chlid) {
      return Scaffold(
        body: pages[nav.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            nav.changeIndex(value);
          },
          currentIndex: nav.currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.image), label: "Images"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: "Video")
          ],
        ),
      );
    });
  }
}
