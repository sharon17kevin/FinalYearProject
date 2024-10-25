import 'package:final_project/screens/data_manager.dart';
import 'package:final_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WhiteDrawer extends StatefulWidget {
  @override
  _WhiteDrawerState createState() => _WhiteDrawerState();
}

class _WhiteDrawerState extends State<WhiteDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Menu',
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.grey
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              Get.to(HomeScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.wysiwyg),
            title: Text('Data Management'),
            onTap: () {
              Get.to(DataManager());
            },
          ),
        ],
      ),
    );
  }
}
