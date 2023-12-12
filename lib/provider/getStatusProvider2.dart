import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsappsaver/constants/constant.dart';

class GetStatusProvider2 extends ChangeNotifier {
  List<FileSystemEntity> _getWSImages = [];
  List<FileSystemEntity> _getWSVideos = [];

  bool _isWhatsAppAvailable = false;

  List<FileSystemEntity> get getWSImages => _getWSImages;
  List<FileSystemEntity> get getWSVideos => _getWSVideos;

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
      final WSdirectory = Directory(Constant.WHATSAPP_PATH);
      if (WSdirectory.existsSync()) {
        final itemsWS = WSdirectory.listSync();

        if (ext == ".mp4") {
          _getWSVideos = itemsWS
              .where((element) => element.path.endsWith(".mp4"))
              .toList();
          notifyListeners();
        } else {
          _getWSImages = itemsWS
              .where((element) => element.path.endsWith(".jpg"))
              .toList();
          notifyListeners();
        }

        _isWhatsAppAvailable = true;
        notifyListeners();

        print(itemsWS.toString());
      } else {
        print("no whatsapp data found");
        _isWhatsAppAvailable = false;
        notifyListeners();
      }
    }
  }
}
