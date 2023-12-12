import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappsaver/constants/constant.dart';

class GetStatusProvider extends ChangeNotifier {
  List<FileSystemEntity> _getWBImages = [];
  List<FileSystemEntity> _getWBVideos = [];

  bool _isWhatsAppAvailable = false;

  List<FileSystemEntity> get getWBImages => _getWBImages;
  List<FileSystemEntity> get getWBVideos => _getWBVideos;

  bool get isWhatsAppAvailable => _isWhatsAppAvailable;
  void getStatus(String ext) async {
    final status = await Permission.storage.request();
    // List<Directory>? directory = await getExternalStorageDirectories();
    if (status.isDenied) {
      Permission.storage.request();
      print("permission denied");
      return;
    }
    if (status.isGranted) {
      // if (directory != null) {
      //   for (Directory dir in directory) {
      //     print(dir.path);
      //   }
      // }
      final WBdirectory = Directory(Constant.WHATSAPPB_PATH);
      if (WBdirectory.existsSync()) {
        final itemsWB = WBdirectory.listSync();

        if (ext == ".mp4") {
          _getWBVideos = itemsWB
              .where((element) => element.path.endsWith(".mp4"))
              .toList();
          notifyListeners();
        } else {
          _getWBImages = itemsWB
              .where((element) => element.path.endsWith(".jpg"))
              .toList();
          notifyListeners();
        }

        _isWhatsAppAvailable = true;
        notifyListeners();

        print(itemsWB.toString());
      } else {
        print("no whatsapp data found");
        _isWhatsAppAvailable = false;
        notifyListeners();
      }
    }
  }
}
