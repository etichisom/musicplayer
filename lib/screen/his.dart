import 'dart:io';

import 'package:flutt/component/bottom.dart';
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
class Hist extends StatefulWidget {
  @override
  _SongState createState() => _SongState();
}

class _SongState extends State<Hist> {
  Box<Songm> s = Hive.box('his');
  Box<Artistm> as = Hive.box<Artistm>('art');
  Change p;
  @override
  Widget build(BuildContext context) {
    p = Provider.of<Change>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),

      body:s.values.toList().length>0 ?ListView(
        physics: BouncingScrollPhysics(),
        children:s.values.toList().reversed.toList().map((e){
          int index = s.values.toList().reversed.toList().indexOf(e);
          return Container(
            child: Container(
              child: ListTile(
                onTap: (){
                  playsong(s.values.toList().reversed.toList(), index).play();
                   setState(() {});
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
        }).toList(),
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

