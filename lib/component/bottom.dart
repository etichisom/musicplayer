


import 'dart:io';

import 'package:flutt/model/songm.dart';
import 'package:flutt/screen/pl.dart';
import 'package:flutt/screen/songdetails.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_playlist/flutter_plugin_playlist.dart';
import 'package:share/share.dart';

import '../app.dart';

class Bottom {

final Songm e;

Bottom({ this.e});

   but(){

   List<Songm> p = [e];
   return showModalBottomSheet(context:cuu, builder: (context){
     return Container(
       height: 400,
       child: ListView(
         physics: BouncingScrollPhysics(),
         children: [
           ListTile(
             trailing: GestureDetector(
               onTap: (){
                 playsong(p, 0).play();
                 Navigator.pop(cuu);
               },
                 child: Icon(Icons.play_circle_outline)),
             leading: Container(
               height: 50,
               width: 50,
               decoration: BoxDecoration(
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
           ListTile(
             onTap: (){
               play();
             },
             title: Text('Add to playlist'),
             leading: Icon(Icons.playlist_add_rounded),
           ),
           ListTile(
             onTap: (){
               playnext(p);
             },
             title: Text('play next'),
             leading: Icon(Icons.queue_play_next),
           ),
           ListTile(
             onTap: (){
               playsong(p, 0).play();
             },
             title: Text('Repeat'),
             leading: Icon(Icons.repeat),
           ),
           ListTile(
             onTap: (){
               shares();
             },
             title: Text('Share'),
             leading: Icon(Icons.share),
           ),
         ],
       ),
     );
   });
 }

   playnext(List<Songm> p) {
   AudioTrack a =AudioTrack(
     title: e.title,
     artist: e.artist,
     albumArt: e.albumArtwork,
     album: e.album,
     isStream: false,
     assetUrl: e.filePath

   );
   if(player.currentTrack == null){
     playsong(p, 0).play();
   }else {
     player.addItem(a, index: ind + 1);
     current.insert(ind + 1, e);
     Navigator.pop(cuu);
   }
   }

   shares() {
     Share.shareFiles([e.filePath], text:e.title);
     Navigator.pop(cuu);
   }

   play() {
     Navigator.pop(cuu);
     Navigator.push(cuu, MaterialPageRoute(builder:(context)=>Pl(e)));
   }


}