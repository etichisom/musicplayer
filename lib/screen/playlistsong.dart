import 'dart:io';

import 'package:flutt/component/adds.dart';
import 'package:flutt/component/bottom.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';

class Psong extends StatefulWidget {
  Map map;

  Psong(this.map);

  @override
  _PsongState createState() => _PsongState();
}

class _PsongState extends State<Psong> {
  Box<Songm> b;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.map['name'].toString()),
        actions: [
          NeumorphicButton(
            onPressed: (){
             add(context);
            },
            child: Icon(Icons.add),
            style: NeumorphicStyle(
              depth: 1,
              color: Colors.white10
            ),
          )
        ],
      ),
      body: b.values.length==0?Center(child: NeumorphicText(
        "Playlist Empty",
        style: NeumorphicStyle(
          depth: 1,  //customize depth here
          color: Colors.deepOrangeAccent, //customize color here
        ),
        textStyle: NeumorphicTextStyle(
          fontSize: 40, //customize size here
          // AND others usual text style properties (fontFamily, fontWeight, ...)
        ),
      ),):
      ListView(
        physics: BouncingScrollPhysics(),
        children:b.values.toList().map((e){
          int index = b.values.toList().indexOf(e);
          return Container(
            child: Container(
              child: ListTile(
                trailing:  PopupMenuButton(
                  itemBuilder: (BuildContext bc) => [
                    PopupMenuItem(child: Text("Remove"), value: "d"),
                    PopupMenuItem(
                        child: Text("More"), value: 'p'),

                  ],
                  onSelected: (route) {
                   sel(route,e);

                  },
                ),
                onTap: (){
                  playsong(b.values.toList(), index).play();
                  },
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
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    b=Hive.box(widget.map['id']);

  }

   add(BuildContext context) async{
    Songm s = await  Navigator.push(context, MaterialPageRoute(builder:(context)=>aSong()));
    if(s != null){
      b.add(s);
      print('added');
      setState(() {

      });
    }

   }

   sel(route, Songm songm) {
    if(route.toString() == 'd'){
      var i = b.values.toList().indexOf(songm);
     var kk= b.keyAt(i);
     b.delete(kk);
     setState(() {

     });
    }else{
      Bottom(e: songm).but();
    }
   }
}
