import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/menu_screen.dart';

class Screen {
  final String title;
  final DecorationImage background;
  final WidgetBuilder contentBuilder;

  Screen({this.title, this.background, this.contentBuilder});
}

class ZoomScaffold extends StatefulWidget {
  final Widget menuScreen;
  final Screen contentScreen;

  ZoomScaffold({
    this.menuScreen,
    this.contentScreen,
  });

  @override  
  _ZoomScaffoldState createState() => new _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold> {

  MenuController menuController;

  @override
  void initState() {
    super.initState();
    menuController = new MenuController()
      ..addListener(() => setState((){}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  Widget createContentDisplay () {
    return zoomAndSlideContent(
      new Container(
      decoration: new BoxDecoration(image: widget.contentScreen.background),
      child: new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                menuController.toogle();
              },
            ),
            title: new Text(
              widget.contentScreen.title,
              style: new TextStyle(fontFamily: 'bebas-neue', fontSize: 25.0),
            ),
          ),
          body: widget.contentScreen.contentBuilder(context)),
      )
    );
  }

  zoomAndSlideContent(Widget content) {
    final slideAmount = 275.0 * menuController.percentOpen;
    final contentScale = 1.0 - (0.2 * menuController.percentOpen);
    final cornerRadius = 10.0 * menuController.percentOpen;

    return new Transform(
      transform: new Matrix4
        .translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
        alignment: Alignment.centerLeft,        
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: const Color(0X44000000),
              offset: const Offset(0.0, 0.5),
              blurRadius: 20.0,
              spreadRadius: 10.0,
            )
          ]
        ),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(cornerRadius), 
          child: content
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: [          
        widget.menuScreen,
        createContentDisplay()        
      ]      
    );
  }
}

class MenuController extends ChangeNotifier {
  MenuState state =  MenuState.closed;
  double percentOpen = 0.0;

  open() {
    this.state = MenuState.open;
    this.percentOpen = 1.0;
    notifyListeners();  
  }

  close() {
    this.state = MenuState.closed;
    this.percentOpen = 0.0;
    notifyListeners();
  }

  toogle() {
    if (this.state == MenuState.open) 
      this.close();      
    else if(this.state == MenuState.closed) 
      this.open();
  }
}

enum MenuState {
  closing,
  closed,
  opening,
  open,  
}