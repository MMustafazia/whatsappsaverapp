import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappsaver/provider/bottom_nav_provider.dart';
import 'package:whatsappsaver/whatsappsaver/bottomNavPage/images/image.dart';
import 'package:whatsappsaver/whatsappsaver/bottomNavPage/videos/video.dart';

class HomeWS extends StatefulWidget {
  const HomeWS({super.key});

  @override
  State<HomeWS> createState() => _HomeWSState();
}

class _HomeWSState extends State<HomeWS> {
  List<Widget> pages = const [ImageHomePage(), VideoHomePage()];
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
