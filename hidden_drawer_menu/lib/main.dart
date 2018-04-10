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
    return new Stack(
      children: [          
        createMenuScreen(),
        //createContentDisplay()
        
      ]      
    );
  }

  Widget createMenuItems() {
    return new Transform(
      transform: new Matrix4.translationValues(
        0.0, 
        225.0,
        0.0
      ),
      child: new Column(
        children: <Widget>[
          new _MenuListItem(
            title: 'THE PADDOCK',
            isSelected: true,
          ),
          new _MenuListItem(
            title: 'THE HERO',
            isSelected: false,
          ),
          new _MenuListItem(
            title: 'HELP US GROWN',
            isSelected: false,
          ),
          new _MenuListItem(
            title: 'SETTINGS',
            isSelected: false,
          ),
        ],
      ),
    );
  }

  Widget createMenuTitle() {
    return new Transform(
      transform: new Matrix4.translationValues(-100.0, 0.0, 0.0),
      child: new OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment.topLeft,
        child: new Padding(
          padding: const EdgeInsets.all(30.0),
          child: new Text(  
            'Menu',
            style: new TextStyle(
              color: const Color(0x88444444),
              fontSize: 240.0,
              fontFamily: 'mermaid'
            ),
            textAlign: TextAlign.left,
            softWrap: false,
          ),
        ),
      ),
    );
  }

  Widget createMenuScreen(){
    return new Container(
      width: double.infinity,
      height: double.infinity,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/dark_grunge_bk.jpg'),
          fit: BoxFit.cover
        )            
      ), 
      child: new Material(
        color: Colors.transparent,
        child: new Stack(
          children: <Widget>[
            createMenuTitle(),
            createMenuItems()
          ],
        ),
      ),         
    );
  }

  Widget createContentDisplay () {
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

class _MenuListItem extends StatelessWidget {
  final String title;
  final bool isSelected;

  _MenuListItem({
    this.title,
    this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: const Color(0X44000000),
      onTap: isSelected ? null : () {} ,
      child: new Container(
        width: double.infinity,
        child: new Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 15.0, bottom: 15.0),
          child: new Text(
            this.title,
            style: new TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontSize: 20.0,
              fontFamily: 'bebas-neeue',
              letterSpacing: 2.0
            ),
          ),
        ),
      ),
    );
  }
}
