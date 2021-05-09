import 'dart:io';

import 'package:flutt/component/pauseplay.dart';
import 'package:flutt/screen/songdetails.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slate/slate.dart';

Widget nowplaying(BuildContext context){
  return StreamBuilder(
    stream: cindex.stream,
      builder: (context,index){
      if(index.data != null){
        return  GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>SongD()));
          },
          child: Container(
            child: ListTile(
              leading: Slate(
                child: Hero(
                  tag: 'tag',
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrangeAccent,
                        image: DecorationImage(
                            image:androidInfo.version.sdkInt >=29?
                            current[index.data].art.length<1?AssetImage('images/d.jpg') :MemoryImage(current[index.data].art):
                            current[index.data].albumArtwork!=null ? FileImage(File(current[index.data].albumArtwork)):
                            AssetImage('images/d.jpg'),
                            fit: BoxFit.cover
                        )
                    ),),
                ),
              ),
              title:  Text(
                current[index.data].title,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
              subtitle:  Text(
                current[index.data].artist,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
              trailing: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                    width: 50,
                    child :pauseplay()),
              ),
            ),
          ),
        );
      }else{
        return SizedBox();
      }
      }
  );
}