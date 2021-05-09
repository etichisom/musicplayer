import 'dart:io';

import 'package:flutt/component/bottom.dart';
import 'package:flutt/component/themeg.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/services/change.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:slate/slate.dart';
class Song extends StatefulWidget {
  @override
  _SongState createState() => _SongState();
}

class _SongState extends State<Song> {
  Box<Songm> s = Hive.box('songg');
  Box<Artistm> as = Hive.box<Artistm>('art');
  ScrollController c = ScrollController();
  Change p;
  @override
  Widget build(BuildContext context) {
    p = Provider.of<Change>(context);
    return Scaffold(

      body:s.values.toList().length>0 ?
          StreamBuilder<int>(
            stream: cindex.stream,
              builder:(context,i){
              return Scrollbar(
                isAlwaysShown: true,
                controller: c,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: c,
                  itemCount:s.values.toList().length ,
                    itemBuilder:(context,index){
                    Songm e = s.values.toList()[index];
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     decoration: BoxDecoration(
                       color:i.data==null?color:current[i.data].title==e.title?Colors.black.withOpacity(0.3):color,
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: ListTile(
                       onTap: (){
                         playsong(s.values.toList(), index).play();

                       },
                       trailing: GestureDetector(
                           onTap: (){
                             Bottom(e: e).but();
                           },
                           child: Icon(Icons.more_vert)),
                       leading: Container(
                         height: 50,
                         width: 50,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             image: DecorationImage(
                                 image:androidInfo.version.sdkInt >=29?
                                 e.art.length<1?AssetImage('images/d.jpg') :MemoryImage(e.art):
                                 e.albumArtwork!=null ? FileImage(File(e.albumArtwork)):
                                 AssetImage('images/d.jpg'),
                                 fit: BoxFit.cover
                             )
                         ),
                       ),
                       title: Text(e.title.toString(),
                         maxLines: 1,),
                       subtitle: Text(e.artist,
                         maxLines: 1,),
                     ),
                   ),
                 );
                }),
              );
              }
          ):Center(child: CircularProgressIndicator()),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(s.values.length);
  }
}

