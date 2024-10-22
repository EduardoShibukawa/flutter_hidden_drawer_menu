import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/zoom_scaffold.dart';

final otherScreen = new Screen(  
  title: 'OTHER SCREEN',  
  background: new DecorationImage(
    image: new AssetImage('assets/other_screen_bk.jpg'),
    fit: BoxFit.cover,
    colorFilter: new ColorFilter.mode(const Color(0XCC000000), BlendMode.multiply),
  ),
  contentBuilder: (BuildContext context) {
    return new Center( 
      child: new Container(
        height: 300.0,
        child: new Padding(
          padding: const EdgeInsets.all(25.0),
          child: new Card(
            child: new Column(
              children: [
                new Image.asset('assets/other_screen_card_photo.jpg'),
                new Expanded(
                  child: new Center(
                    child: new Text('This is another screen!'),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
);