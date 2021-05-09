import 'dart:io';

import 'package:flutt/component/bottom.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:slate/slate.dart';

class aSong extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<aSong> {
  List<Songm> s = [];
  List<Songm> selected = [];
  var se = 'my';
  List<Songm> ss = List<Songm>();
  Box<Songm> d = Hive.box('songg');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration:InputDecoration(
                suffix: GestureDetector(
                    onTap: (){

                    },
                    child: Icon(Icons.search,color: Colors.red,)),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white24,
                hintText: 'Search for songs',
                disabledBorder: InputBorder.none
            ),
            onChanged: (v){
              als(v);
            },


          ),
        ),
      ),
      body:s.length==0?SizedBox():ListView.separated(
          separatorBuilder: (context, indd){
            return Divider();
          },
          itemCount: s.length,
          itemBuilder:(context,ind){
            return ListTile(
              onTap: (){
              Navigator.pop(context,s[ind]);

              },
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image:androidInfo.version.sdkInt >=29?
                        s[ind].art.length<1?AssetImage('images/d.jpg') :MemoryImage(s[ind].art):
                        s[ind].albumArtwork!=null?FileImage(File(s[ind].albumArtwork)):
                        AssetImage('images/d.jpg'),
                        fit: BoxFit.cover
                    )
                ),
              ),
              title: Text(s[ind].title.toString(),
                maxLines: 1,),
              subtitle: Text(s[ind].artist,
                maxLines: 1,),
            );
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    s = d.values.toList();

  }
  als(String id){
    List<Songm> sl = [];

    d.values.toList().forEach((element) {
      if(element.title.trim().toLowerCase().contains(id)){
        sl.add(element);
      }
    });
    setState(() {
      s=sl;
    });

  }
}
