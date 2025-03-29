import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repo_app/Screens/home_page.dart';
import 'package:repo_app/Screens/splash_screen.dart';
import 'package:repo_app/theme/theme.dart';

void main() {
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repository Search',
      debugShowCheckedModeBanner: false,
      theme: AppTheme,
      home: SplashScreen(),
    );
  }
}

