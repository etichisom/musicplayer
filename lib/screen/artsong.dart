

import 'dart:io';
import 'dart:typed_data';

import 'package:flutt/component/bottom.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/services/change.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:slate/slate.dart';

class ArtSOng extends StatefulWidget {
  Artistm a;


  ArtSOng(this.a);

  @override
  _ArtSOngState createState() => _ArtSOngState();
}

class _ArtSOngState extends State<ArtSOng> {
  List<Songm> s = [];
  Change p;
  @override
  Widget build(BuildContext context) {
    p = Provider.of<Change>(context);
    return Scaffold(
     body: SafeArea(
       child: CustomScrollView(
         physics: BouncingScrollPhysics(),
         slivers: [
           SliverAppBar(
             expandedHeight: 300,
             pinned: false,
             flexibleSpace:SafeArea(
               child: Stack(
         children: [
           Container(
             height: 300,
             width:MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
                 image: DecorationImage(
                     image:androidInfo.version.sdkInt >=29?
                     widget.a.art.length<1?AssetImage('images/d.jpg') :MemoryImage(widget.a.art):
                     widget.a.artistArtPath!=null ? FileImage(File(widget.a.artistArtPath)):
                     AssetImage('images/d.jpg'),
                     fit: BoxFit.cover
                 )
             ),

           ),
               Container(
              height: 300,
              width:MediaQuery.of(context).size.width,
                 color: Colors.black.withOpacity(0.5),
               ),
                 Positioned(
                 bottom: 0,
                 child: Container(
                   color: Colors.black.withOpacity(0.1),
                height: 50, width:MediaQuery.of(context).size.width,

                child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 10),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(widget.a.name,
                           maxLines: 1,
                           overflow: TextOverflow.clip,
                           style: TextStyle(
                               fontSize: 24,
                               color: Colors.white,
                               fontWeight: FontWeight.bold
                           ),),
                         Text(widget.a.numberOfTrack + ' Tracks',
                           style: TextStyle(
                              color: Colors.grey

                           ),),
                       ],
                     ),
                   ),
                 ],
           ),
              ),
            ),
              Positioned(
                right: 15,
                bottom: 30,
                child: GestureDetector(
             onTap: (){
                 s.shuffle();
                 setState(() {});
                 playsong(s, 0).play();
             },
                 child: Container(
                 decoration: BoxDecoration(
                   color: Colors.deepPurpleAccent,
                   shape: BoxShape.circle,
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black,
                       spreadRadius: 0.5,
                       blurRadius: 2
                     )
                   ]
                 ),
                   child: Padding(
                     padding: const EdgeInsets.all(11.0),
                     child: Icon(Icons.shuffle,size: 25,),
                   ),
                 ),
           ),
              )
         ],
       ),
     ),
           ),
       SliverList(
         delegate: SliverChildBuilderDelegate(
                 (BuildContext context, int pdIndex) {
               return ListTile(
                 onTap: (){
                   playsong(s, pdIndex).play();
                 },
                 subtitle: Text(s[pdIndex].artist,maxLines: 1,),
                   trailing: GestureDetector(
                     child: Icon(Icons.more_vert),
                   onTap: (){
                   Bottom(e: s[pdIndex]).but();
                   },),
                  title: Text(s[pdIndex].title,
                   maxLines: 1,),
               );
             },
             childCount: s.length,
       ),
     ),

         ],
       ),
     )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    als(widget.a.id);
  }

  als(String id){
    List<Songm> sl = [];
    Box<Songm> d = Hive.box('songg');
    d.values.toList().forEach((element) {
      if(element.artistId == id){
        sl.add(element);
      }
    });
    setState(() {
      s=sl;
    });

  }

}
