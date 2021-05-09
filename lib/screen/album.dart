import 'dart:io';

import 'package:flutt/model/albumm.dart';
import 'package:flutt/screen/albumsong.dart';
import 'package:flutt/services/change.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:slate/slate.dart';

class Album extends StatefulWidget {
  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  Change p;
  Box<Albumm> a = Hive.box('alumbb');
  ScrollController c = ScrollController();
  @override
  Widget build(BuildContext context) {
    p = Provider.of<Change>(context);
    return Scaffold(
      body:Scrollbar(
        controller: c,
        isAlwaysShown: true,
        child: GridView.builder(
          controller: c,
          itemCount: a.values.toList().length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            var e = a.values.toList()[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.scale,
                      alignment: Alignment.center, child:Albumsong(e,index)));
                },
                child: Column(
                  children: [
                    Expanded(child: Hero(
                      tag:index.toString(),
                      child: Slate(
                        child: Container(
                decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                image:androidInfo.version.sdkInt >=29?
                e.art.length<1?AssetImage('images/d.jpg') :MemoryImage(e.art):
                e.albumArt!=null ? FileImage(File(e.albumArt)):
                AssetImage('images/d.jpg'),
                fit: BoxFit.cover
                )
                        )),
                      ),
                    )),
                    Text(e.title,maxLines: 1,),
                    Text(e.artist,maxLines: 1,style: TextStyle(
                        color: Colors.grey
                    ),)

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
