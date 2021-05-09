import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
Color color = Colors.white10;
ThemeData light =ThemeData.light().copyWith(
    scaffoldBackgroundColor: Color.fromRGBO(235,235,227,1 ),
    primaryColor: Colors.purple,
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
        backgroundColor:Color.fromRGBO(235,235,227,1 )
    )
);
ThemeData dark =ThemeData.dark().copyWith(
    scaffoldBackgroundColor:Color.fromRGBO(31, 33, 32, 3),
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
        backgroundColor:Color.fromRGBO(31, 33, 32, 3)
    )
);
dar(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:Brightness.dark,
    systemNavigationBarColor: Colors.transparent,

  ));
}
lig(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:Brightness.light,
    systemNavigationBarColor: Colors.transparent,

  ));
}