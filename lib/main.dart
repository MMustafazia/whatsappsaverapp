import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsappsaver/provider/bottom_nav_provider.dart';
import 'package:whatsappsaver/provider/getStatusProvider2.dart';
import 'package:whatsappsaver/provider/getStatusprovider.dart';
import 'package:whatsappsaver/screen/home.dart';
import 'package:whatsappsaver/whatsappsaver/homews.dart';
import 'package:whatsappsaver/whatsappsaver/splashWS.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: SplashScreenWS(),
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => GetStatusProvider()),
        ChangeNotifierProvider(create: (_) => GetStatusProvider2()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenWS(),
      ),
    );
  }
}
