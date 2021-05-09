import 'dart:io';

import 'package:flutt/component/bottom.dart';
import 'package:flutt/component/themeg.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:slate/slate.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Songm> s = [];
  var se = 'my';
  Box<Songm> d = Hive.box('songg');
  List<Songm> ss = List<Songm>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                        enabledBorder: InputBorder.none,
                        hintText: 'Search for songs',
                        disabledBorder: InputBorder.none
                    ),
                    onChanged: (v){
                      als(v);
                    },


                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: s.length==0?SizedBox():ListView.separated(
                  separatorBuilder: (context, indd){
                    return Divider();
                  },
                  itemCount: s.length,
                    itemBuilder:(context,ind){
                    return ListTile(
                      onTap: (){
                        playsong(s, ind).play();

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
                      trailing: GestureDetector(
                          onTap: (){
                            Bottom(e: s[ind]).but();
                          },
                          child: Icon(Icons.more_vert)),
                      title: Text(s[ind].title.toString(),
                        maxLines: 1,),
                      subtitle: Text(s[ind].artist,
                        maxLines: 1,),
                    );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    s =[];
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
