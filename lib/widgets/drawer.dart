import 'package:flutter/material.dart';
import 'package:whatsappsaver/whatsappsaver/homew.dart';
import 'package:whatsappsaver/whatsappsaver/homews.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'WhatsApp Status Saver',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('WhatsApp'),
            onTap: () {
              // Handle item 1 tap
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HomeW())); // // Close the drawer
            },
          ),
          ListTile(
            title: Text('WhatsApp Business'),
            onTap: () {
              // Handle item 2 tap
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HomeWS())); // Close the drawer
            },
          ),
          // Add more ListTile items as needed
        ],
      ),
    );
  }
}
