import 'package:flutt/screen/browse.dart';
import 'package:flutt/screen/playlist.dart';
import 'package:flutt/screen/search.dart';
import 'package:flutt/screen/tab.dart';
import 'package:flutter/material.dart';



class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "Page2")
      child = Tabs();
    else if(tabItem == "Page3")
      child =Playlist();
    else if(tabItem == "Page4")
      child = Search();
    else if(tabItem == "Page1")
      child = Broe();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}
