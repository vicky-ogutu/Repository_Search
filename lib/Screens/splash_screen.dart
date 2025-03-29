import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RepositorySearchScreen()));

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/splash_icon.png", width: 40, height: 40),
            const SizedBox(height: 30),// Custom PNG Icon
            Text("Welcome to Github Repository"),

          ],
        ),
      ),
    );
  }
}
