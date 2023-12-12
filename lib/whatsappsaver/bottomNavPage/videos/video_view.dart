import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String videoPath;
  const VideoView({super.key, required this.videoPath});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  List<Widget> buttonList = [
    Icon(Icons.download),
    Icon(Icons.share),
  ];
  ChewieController? _chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.file(
        File(widget.videoPath),
      ),
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      aspectRatio: 5 / 8,
      errorBuilder: ((context, errorMessage) {
        return Center(
          child: Text(errorMessage),
        );
      }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chewieController!.pause();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Chewie(controller: _chewieController!),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(buttonList.length, (index) {
              return FloatingActionButton(
                heroTag: "$index",
                onPressed: () {
                  switch (index) {
                    case 0:
                      print("Download");
                      ImageGallerySaver.saveFile(widget.videoPath!)
                          .then((value) => {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Video Downloaded'),
                                  ),
                                ),
                              });
                      break;

                    case 1:
                      print("Share");
                      FlutterNativeApi.shareImage(widget.videoPath!);

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
