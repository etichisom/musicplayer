import 'package:flutt/model/songm.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class His extends StatefulWidget {
  @override
  _HisState createState() => _HisState();
}

class _HisState extends State<His> {
  Box<Songm> h = Hive.box('his');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:(){

          print(h.values.length);
          //h.values.toList().forEach((element) {print(element.title);});
        },
      ),
    );
  }
}
