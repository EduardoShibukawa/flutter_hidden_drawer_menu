import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/zoom_scaffold.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin{

  AnimationController titleAnimationController;  

  @override
  void initState() {
    super.initState();
    this.titleAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this
    );
  }

  @override
  void dispose() {
    titleAnimationController.dispose();
    super.dispose();
  }

  Widget createMenuItems(MenuController menuController) {
    final selectedIndex = 0;
    final titles = [      
      'THE PADDOCK',
      'THE HERO',
      'HELP US GROWN',
      'SETTINGS',          
    ];    

    final listItems = [];
    final animationIntervalDuration = 0.5;
    final perListItemDelay = menuController.state != MenuState.closing ? 0.15 : 0.0;
    for (var i = 0; i < titles.length; i++) {
      final animationIntervalStart = i * perListItemDelay;
      final animationIntervalnEnd = animationIntervalStart + animationIntervalDuration;

      listItems.add(
        new AnimatedMenuListItem(
          menuState: menuController.state,
          duration: const Duration(milliseconds: 600),
          curve: new Interval(
            animationIntervalStart, 
            animationIntervalnEnd, 
            curve: Curves.easeOut
          ),
          menuListItem: new _MenuListItem(
            title: titles[i],
            isSelected: i == selectedIndex,
            onTap: () {
              menuController.close();
            },
          ),
        )
      );
    }
    
    return new Transform(
      transform: new Matrix4.translationValues(
        0.0, 
        225.0,
        0.0
      ),
      child: new Column(
        children: listItems,              
      ),
    );
  }

  Widget createMenuTitle(MenuController menuController) {    
    switch (menuController.state) {
      case MenuState.open:
      case MenuState.opening:      
        titleAnimationController.forward();
        break;
      case MenuState.closed:
      case MenuState.closing:      
        titleAnimationController.reverse();
        break;
      default: throw 'MenuController State not handled by createMenuTitle';
    }

    return new AnimatedBuilder(
      animation: titleAnimationController,
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
      builder: (BuildContext context, Widget child) {
        return new Transform(
          transform: new Matrix4.translationValues(
            250 * (1.0  - titleAnimationController.value) - 100.0, 
            0.0, 
            0.0
          ),
          child: child
        );
      },
    );    
  }

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffoldMenuController(
      builder: (BuildContext context, MenuController menuController) {
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
                createMenuTitle(menuController),
                createMenuItems(menuController)
              ],
            ),
          ),         
        );
      },
    );
  }
}

class AnimatedMenuListItem extends ImplicitlyAnimatedWidget {

  final _MenuListItem menuListItem;
  final MenuState menuState;
  final Duration duration;

  AnimatedMenuListItem({
    this.menuListItem, 
    this.menuState, 
    this.duration,
    curve
  }) : super(duration: duration, curve: curve);
  
  @override
  _AnimatedMenuListItemState createState() => new _AnimatedMenuListItemState();
}

class _AnimatedMenuListItemState extends AnimatedWidgetBaseState<AnimatedMenuListItem> {

  final double closedSlidePosition = 200.0;
  final double openSlidePosition = 0.0;

  Tween<double> _translation;
  Tween<double> _opacity;

  
  @override
  void forEachTween(TweenVisitor visitor) {
    var slide, opacity;

    switch (widget.menuState) {
      case MenuState.closed:
      case MenuState.closing:
        slide = closedSlidePosition;                
        opacity = 0.0;
        break;

      case MenuState.open:
      case MenuState.opening:
        slide = openSlidePosition;
        opacity = 1.0;
        break;
      default: throw "Can't handle MenuState in _AnimatedMenuListItem.forEachTween";
    }

    _translation = visitor(
      _translation,
      slide,
      (dynamic value) => new Tween<double>(begin: value),
    );
    _opacity = visitor(
      _opacity,
      opacity,
      (dynamic value) => new Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Opacity(
      opacity: _opacity.evaluate(animation),
      child: new Transform(
        transform: new Matrix4.translationValues(
          0.0, 
          _translation.evaluate(animation), 
          0.0
        ),
        child: widget.menuListItem,
      ),
    );
  }
}

class _MenuListItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;

  _MenuListItem({
    this.title,
    this.isSelected,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: const Color(0X44000000),
      onTap: isSelected ? null : this.onTap ,
      child: new Container(
        width: double.infinity,
        child: new Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 15.0, bottom: 15.0),
          child: new Text(
            this.title,
            style: new TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontSize: 15.0,
              fontFamily: 'bebas-neeue',
              letterSpacing: 2.0
            ),
          ),
        ),
      ),
    );
  }
}
