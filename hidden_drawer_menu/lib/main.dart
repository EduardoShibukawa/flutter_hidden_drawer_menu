import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/menu_screen.dart';
import 'package:hidden_drawer_menu/other_screen.dart';
import 'package:hidden_drawer_menu/restaurant_screen.dart';
import 'package:hidden_drawer_menu/zoom_scaffold.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var activeScreen = restaurantScreen;

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffold(
      menuScreen: new MenuScreen(),
      contentScreen: activeScreen,
    );
  }
}
