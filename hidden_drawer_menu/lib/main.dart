import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/other_screen.dart';
import 'package:hidden_drawer_menu/restaurant_screen.dart';

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
  var activeScreen = otherScreen;
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(image: activeScreen.background),
      child: new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {},
            ),
            title: new Text(
              activeScreen.title,
              style: new TextStyle(fontFamily: 'bebas-neue', fontSize: 25.0),
            ),
          ),
          body: activeScreen.contentBuilder(context)),
    );
  }
}

