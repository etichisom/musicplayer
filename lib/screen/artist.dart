import 'dart:io';

import 'package:flutt/model/artistm.dart';
import 'package:flutt/screen/artsong.dart';
import 'package:flutt/services/change.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Artist extends StatefulWidget {
  @override
  _ArtistState createState() => _ArtistState();
}

class _ArtistState extends State<Artist> {
  Change p;
  Box<Artistm> a = Hive.box('art');
  ScrollController c = ScrollController();
  @override
  Widget build(BuildContext context) {
    p = Provider.of<Change>(context);
    return Scaffold(
      body:a.values.toList().length>0?
      Scrollbar(
        isAlwaysShown: true,
        thickness: 5,
        controller: c,
        child: ListView(
          controller: c,
          physics: BouncingScrollPhysics(),
          children:a.values.toList().map((e){
            return Container(
              child: Container(
                child: ListTile(
                  onTap: (){
                    Navigator.push(context, PageTransition(type: PageTransitionType.scale,
                        alignment: Alignment.center, child:ArtSOng(e)));

                  },

                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        image: DecorationImage(
                            image:androidInfo.version.sdkInt >=29?
                            e.art.length<1?AssetImage('images/d.jpg') :MemoryImage(e.art):
                            e.artistArtPath!=null ? FileImage(File(e.artistArtPath)):
                            AssetImage('images/d.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  title: Text(e.name.toString(),
                    maxLines: 1,),
                  subtitle: Text(e.numberOfTrack,
                    maxLines: 1,),
                ),
              ),
            );
          }).toList(),
        ),
      ):Center(child: CircularProgressIndicator()),
    );
  }
}
