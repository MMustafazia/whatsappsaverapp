import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappsaver/whatsappsaver/homews.dart';

class SplashScreenWS extends StatefulWidget {
  const SplashScreenWS({super.key});

  @override
  State<SplashScreenWS> createState() => _SplashScreenWSState();
}

class _SplashScreenWSState extends State<SplashScreenWS> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context,
          CupertinoPageRoute(builder: (_) => HomeWS()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(child: Image.asset("assets/logo.png")),
    );
  }
}
