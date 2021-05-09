import 'package:flutt/component/themeg.dart';
import 'package:flutt/main.dart';
import 'package:flutt/model/albumm.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/screen/album.dart';
import 'package:flutt/screen/artist.dart';
import 'package:flutt/screen/idsong.dart';
import 'package:flutt/screen/search.dart';
import 'package:flutt/screen/song.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:slate/slate.dart';

import '../app.dart';

class Tabs extends StatefulWidget {
  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController t ;
  final key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
             labelColor: Colors.deepOrange,
             indicatorColor: Colors.red,
              indicatorWeight: 2,
             indicatorSize:TabBarIndicatorSize.label,
             controller: t,
               tabs: [
             Tab(
               text:'Song',
             ),
             Tab(
               text:'Artist',

             ),
             Tab(
               text:'Album',



             )
           ]),
         Expanded(
           child: Container(
             child: TabBarView(
               controller: t,
                 children: [
                   Song(),
                   Artist(),
                   Album(),

                 ]),
           ),
         )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    t = TabController(length: 3, vsync:this);
  }


}
