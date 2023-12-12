import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappsaver/provider/getStatusprovider.dart';
import 'package:whatsappsaver/whatsappsaver/bottomNavPage/images/image_view.dart';
import 'package:whatsappsaver/widgets/drawer.dart';

class ImageHomePage extends StatefulWidget {
  const ImageHomePage({super.key});

  @override
  State<ImageHomePage> createState() => _ImageHomePageState();
}

class _ImageHomePageState extends State<ImageHomePage> {
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
        title: Text("Image Status"),
      ),
      drawer: DrawerWidget(),
      body: Consumer<GetStatusProvider>(builder: (context, file, child) {
        if (_isFetched == false) {
          file.getStatus(".jpg");
          Future.delayed(Duration(microseconds: 1), () {
            _isFetched = true;
          });
        }
        return file.isWhatsAppAvailable == false
            ? Center(
                child: Text("WhatsApp Not Available!"),
              )
            : file.getWBImages.isEmpty
                ? Center(
                    child: Text("No Images Found"),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        children:
                            List.generate(file.getWBImages.length, (index) {
                          final data = file.getWBImages[index];
                          String imagedata = data.path;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => ImageView(
                                          imagePath: data.path,
                                        )),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(data.path))),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        })),
                  );
      }),
    );
  }
}
