import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappsaver/provider/getStatusProvider2.dart';
import 'package:whatsappsaver/provider/getStatusprovider.dart';
import 'package:whatsappsaver/utils/getthumbnail.dart';
import 'package:whatsappsaver/whatsappsaver/bottomNavPage/videos/video_view.dart';
import 'package:whatsappsaver/widgets/drawer.dart';

class VideoHome2Page extends StatefulWidget {
  const VideoHome2Page({super.key});

  @override
  State<VideoHome2Page> createState() => _VideoHome2PageState();
}

class _VideoHome2PageState extends State<VideoHome2Page> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Provider.of<GetStatusProvider>(context, listen: false).getStatus();
  // }
  bool _isFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos Status"),
      ),
      drawer: DrawerWidget(),
      body: Consumer<GetStatusProvider2>(builder: (context, file, child) {
        if (_isFetched == false) {
          file.getStatus(".mp4");
          Future.delayed(Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return file.isWhatsAppAvailable == false
            ? Center(
                child: Text("WhatsApp Not Available!"),
              )
            : file.getWSVideos.isEmpty
                ? Center(
                    child: Text("No Video Status Found"),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        children:
                            List.generate(file.getWSVideos.length, (index) {
                          final data = file.getWSVideos[index];
                          return FutureBuilder<String>(
                              future: getThumbnail(data.path),
                              builder: (context, snapshot) {
                                return snapshot.hasData
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (_) => VideoView(
                                                      videoPath: data.path,
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      File(snapshot.data!))),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              });
                        })),
                  );
      }),
    );
  }
}
