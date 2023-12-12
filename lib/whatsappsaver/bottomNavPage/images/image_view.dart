import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageView extends StatefulWidget {
  final String? imagePath;
  const ImageView({super.key, this.imagePath});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  List<Widget> buttonList = [
    Icon(Icons.download),
    Icon(Icons.print),
    Icon(Icons.share),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              image: DecorationImage(
                  image: FileImage(File(widget.imagePath!)),
                  fit: BoxFit.contain)),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(buttonList.length, (index) {
              return FloatingActionButton(
                heroTag: "$index",
                onPressed: () async {
                  switch (index) {
                    case 0:
                      print("Download");
                      ImageGallerySaver.saveFile(widget.imagePath!)
                          .then((value) => {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Image Downloaded'),
                                  ),
                                ),
                              });
                      break;
                    case 1:
                      print("Print");
                      FlutterNativeApi.printImage(
                          widget.imagePath!, widget.imagePath!.split("/").last);
                      break;
                    case 2:
                      print("Share");
                      FlutterNativeApi.shareImage(widget.imagePath!);
                      break;
                  }
                },
                child: buttonList[index],
              );
            }),
          ),
        ));
  }
}
