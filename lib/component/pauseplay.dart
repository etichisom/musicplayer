import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget pauseplay(){
  return StreamBuilder(
      stream: state.stream,
      builder:(context,dat){
        if(dat.data == 'stopped'){
          return Text(dat.data.toString());
        }else if(dat.data == 'playing'){
          return  GestureDetector(
              onTap: (){
                player.pause();
              },
              child: Icon(Icons.pause,size: 45,));
        }else if(dat.data == 'paused'){
          return  GestureDetector(
              onTap: (){
                player.play();
              },
              child: Icon(Icons.play_arrow_rounded,size: 45,));
        }
        else{
          return SizedBox();
        }
      }
  );
}