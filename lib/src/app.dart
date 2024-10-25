import 'package:flutter/material.dart';
import 'package:final_project/screens/home.dart';
import 'package:get/get.dart';
import 'package:final_project/theme/theme_constants.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: lightTheme,
    );
  }
}
