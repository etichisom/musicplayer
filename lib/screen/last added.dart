import 'dart:io';

import 'package:flutt/component/bottom.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/services/change.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:slate/slate.dart';
class Songl extends StatefulWidget {
  List<Songm> l;

  Songl(this.l);

  @override
  _SongState createState() => _SongState();
}

class _SongState extends State<Songl> {
  Box<Songm> s = Hive.box('songg');
  Box<Artistm> as = Hive.box<Artistm>('art');
  Change p;
  List<Songm> d = List<Songm>();
  List<Songm> iss= [];



  @override
  Widget build(BuildContext context) {
    p = Provider.of<Change>(context);
    return Scaffold(
     appBar: AppBar(
       title:Text('Last added') ,
     ),
      body:widget.l.length>0 ?ListView(
        physics: BouncingScrollPhysics(),
        children:iss.reversed.toList().map((e){
          int index = iss.reversed.toList().indexOf(e);
          return Container(
            child: Container(
              child: ListTile(
                onTap: (){

                 // playsong(iss.reversed.toList(), index).play();
                  print(e.dateTime);

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
    so();
  }
  so(){
 iss = s.values.toList();
    iss.sort((a,b){
      if(a.track == null) return -1;
      return a.track.compareTo(b.track);
    });
    setState(() {});
  }
}

