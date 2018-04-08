import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/zoom_scaffold.dart';

final Screen restaurantScreen = new Screen(
    title: 'THE PALEO PADDOCK',
    background: new DecorationImage(
        image: new AssetImage('assets/wood_bk.jpg'), fit: BoxFit.cover),
    contentBuilder: (BuildContext context) {
      return new ListView(
        children: [
          new _RestaurantCard(
            headImageAssetPath: 'assets/eggs_in_skillet.jpg',
            icon: Icons.fastfood,
            iconBackgroundColor: Colors.orange,
            title: "it domacce",
            subtitle: '78 5TH AVENUE, NEW YORK',
            heartcount: 84,
          ),
          new _RestaurantCard(
            headImageAssetPath: 'assets/steak_on_cooktop.jpg',
            icon: Icons.local_dining,
            iconBackgroundColor: Colors.red,
            title: "MC Grady",
            subtitle: '79 5TH AVENUE, NEW YORK',
            heartcount: 65,
          ),
          new _RestaurantCard(
            headImageAssetPath: 'assets/spoons_of_spices.jpg',
            icon: Icons.fastfood,
            iconBackgroundColor: Colors.purpleAccent,
            title: "Sugar & Spice",
            subtitle: '80 5TH AVENUE, NEW YORK',
            heartcount: 100,
          ),
        ],
      );
    });

class _RestaurantCard extends StatelessWidget {
  final String headImageAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int heartcount;

  _RestaurantCard(
      {this.headImageAssetPath,
      this.icon,
      this.iconBackgroundColor,
      this.title,
      this.subtitle,
      this.heartcount});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        elevation: 10.0,
        child: new Column(
          children: [
            new Image.asset(
              this.headImageAssetPath,
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            new Row(
              children: [
                new Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: new Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                        color: this.iconBackgroundColor,
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(15.0))),
                    child: new Icon(
                      this.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        this.title,
                        style: const TextStyle(
                            fontSize: 25.0, fontFamily: 'mermaid'),
                      ),
                      new Text(
                        this.subtitle,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'bebas-neue',
                          letterSpacing: 1.0,
                          color: const Color(0XFFAAAAAA),
                        ),
                      )
                    ],
                  ),
                ),
                new Container(
                  width: 2.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(colors: [
                    Colors.white,
                    Colors.white,
                    const Color(0XFFAAAAAA)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: new Column(
                    children: [
                      new Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      new Text('$heartcount')
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
