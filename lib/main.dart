import 'package:flutter/material.dart';
import 'package:todo_list/source/widget/screen/add_item_screen.dart';
import 'package:todo_list/source/widget/screen/home_screen.dart';
import 'package:todo_list/source/widget/screen/list_item_screen.dart';
import 'package:todo_list/source/widget/screen/notifications_screen.dart';
import 'package:todo_list/source/widget/screen/setting_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'TodoApp',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => const HomeScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/listItem': (context) => ListItemScreen(),
      '/setting': (context) => SettingScreen(),
      '/notifications': (context) => NotificationsScreen(),
      '/addItem': (context) => AddItemScreen(),
    },
  ));
}
