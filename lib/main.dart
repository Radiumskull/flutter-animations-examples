import 'package:flutter/material.dart';
import 'package:flutteranimations/pages/AnimatedScreen.dart';
import 'package:flutteranimations/pages/Animated_List_View.dart';
import 'package:flutteranimations/pages/hero_demo.dart';
import 'package:flutteranimations/pages/delayed_animation.dart';
import 'package:flutteranimations/pages/hero_demo_two.dart';
import 'package:flutteranimations/pages/radial_selector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RadialSelectorPage(),
    );
  }
}