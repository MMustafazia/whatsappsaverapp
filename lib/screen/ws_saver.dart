import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class WS_SaverScreen extends StatefulWidget {
  const WS_SaverScreen({super.key});

  @override
  State<WS_SaverScreen> createState() => _WS_SaverScreenState();
}

class _WS_SaverScreenState extends State<WS_SaverScreen> {
  List<String> statusList = [];

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
      print("status of permission= ${status}");
    }

    _loadStatuses();
  }

  Future<void> _loadStatuses() async {
    statusList.clear();
    final Directory? extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir?.path}/WhatsApp Business/Media/.Statuses';
    final Directory statusDir = Directory(dirPath);

    if (statusDir.existsSync()) {
      statusList = statusDir.listSync().map((file) => file.path).toList();
    }

    setState(() {});
  }

  Future<void> _saveStatus(String statusPath) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String savePath = '${appDir.path}/SavedStatus';
    final Directory saveDir = Directory(savePath);

    if (!saveDir.existsSync()) {
      saveDir.createSync(recursive: true);
    }

    final String fileName = statusPath.split('/').last;
    final String newPath = '$savePath/$fileName';

    File(statusPath).copySync(newPath);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Status saved successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Status Saver'),
      ),
      body: ListView.builder(
        itemCount: statusList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Status $index'),
            leading: Image.file(File(statusList[index])),
            trailing: IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveStatus(statusList[index]),
            ),
          );
        },
      ),
    );
  }
}
