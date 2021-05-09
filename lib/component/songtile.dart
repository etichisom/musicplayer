import 'dart:io';

import 'package:flutt/model/songm.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom.dart';
Widget st (List<Songm> d){
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    children:d.map((e){
      int index = d.indexOf(e);
      return Container(
        child: Container(
          child: ListTile(
            onTap: (){
              playsong(d, index).play();

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
  );
}