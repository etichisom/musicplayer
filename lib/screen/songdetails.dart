import 'dart:io';

import 'package:flutt/component/bottom.dart';
import 'package:flutt/screen/lyri.dart';
import 'package:flutt/screen/pl.dart';
import 'package:flutt/screen/que.dart';
import 'package:flutt/services/change.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:lyrics/lyrics.dart';
import 'package:provider/provider.dart';
import 'package:slate/slate.dart';

import '../app.dart';

int ind = 0;
class SongD extends StatefulWidget {
  @override
  _SongDState createState() => _SongDState();
}

class _SongDState extends State<SongD> {
  Change p;
  final Controller c = Get.put(Controller());
  Size size;
  var e;
  Stream stream = cindex.stream;
  final key = GlobalKey<ScaffoldState>();
  var wid ;
  @override
  Widget build(BuildContext context) {
    p = Provider.of<Change>(context);
    size = MediaQuery.of(context).size;
    wid =  MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      primary: false,
      backgroundColor: Colors.brown,
      key: key,
      body: StreamBuilder<int>(
        stream:cindex.stream.asBroadcastStream() ,
        builder: (context,index){
          if(index.hasError){
            return SizedBox();

           } else if(index==null){
            return SizedBox();
          }
          else if( index.data != null){
            ind=index.data;
            print(index.data);
            return ImagePixels(
              imageProvider:androidInfo.version.sdkInt >=29?
              current[index.data].art.length<1?AssetImage('images/d.jpg') :MemoryImage(current[index.data].art):
              current[index.data].albumArtwork!=null ? FileImage(File(current[index.data].albumArtwork)):
              AssetImage('images/d.jpg'),
              defaultColor: Colors.grey,
              builder: (context, img) =>Container(
               decoration: BoxDecoration(
                 gradient:LinearGradient(
                   colors: [
                     img.pixelColorAtAlignment(Alignment.bottomCenter).withOpacity(0.5),
                     img.pixelColorAtAlignment(Alignment.topCenter).withOpacity(0.5)
                   ]
                 )
               ),
                height: size.height,
                width: size.width,
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                child: Neumorphic(
                                    style: NeumorphicStyle(
                                        shape: NeumorphicShape.concave,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        depth: 1,
                                        color: Colors.white10
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.arrow_back,size: 25,color: Colors.white,),
                                    )),
                            onTap: (){
                                  Navigator.pop(context);
                            },),
                            SizedBox(width: 3,),
                            Expanded(child: Center(
                              child: Text(
                                current[index.data].album,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            )),
                            SizedBox(width: 3,),
                            GestureDetector(child: Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    depth: 1,
                                    lightSource: LightSource.topLeft,
                                    color: Colors.white10
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(cuu, MaterialPageRoute(builder:(context)=>Pl(
                                        current[ind]
                                      )));
                                    },
                                      child: Icon(Icons.add,size: 25,color: Colors.white)),
                                ))),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Hero(
                          tag: 'tag',
                          child: PhysicalModel(
                            color: Colors.black,
                            elevation: 4,
                            borderRadius:BorderRadius.circular(10) ,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height:player.isPlaying?wid-40:wid-80,
                              width: player.isPlaying?wid-40:wid-80,
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
                      ),
                      ListTile(
                        title:  Text(
                          current[index.data].title,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                        trailing: GestureDetector(
                            child: Icon(Icons.more_vert),
                          onTap: (){
                            Bottom(e: current[index.data]).but();
                          },),
                        subtitle:  Text(
                          current[index.data].artist,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      StreamBuilder<int>(
                        stream: cdua.stream,
                          builder: (context,s){
                          if(s.data != null){
                            int i = int.parse(current[index.data].duration);
                            var d = Duration(milliseconds: i).inSeconds;
                           return  Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: NeumorphicSlider(
                               height: 8,
                                 value:s.data.toDouble(),
                                 max: d.toDouble(),
                                 onChanged: (v){
                                   cdua.sink.add(v.toInt());
                                 },
                               onChangeEnd: (v){
                                 player.seekTo(v.toInt());
                               },
                               style: SliderStyle(
                                 accent: Colors.brown,
                                 depth: -4
                               ),

                             ),
                           );

                            }else{
                            return SizedBox();
                          }
                          }
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder<int>(
                                stream: cdua.stream,
                                builder:(context, i){
                                  if( i.data != null){
                                    var d = Duration(seconds: i.data);
                                    return  Text(
                                      d.toString().split('.').first,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    );
                                  }else{
                                    return SizedBox();
                                  }
                                }
                            ),
                            StreamBuilder<int>(
                                stream: cp.stream,
                                builder:(context, i){
                                  if( i.data != null){
                                    var d = Duration(seconds: i.data);
                                    return  Text(
                                      d.toString().split('.').first,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    );
                                  }else{
                                    return SizedBox();
                                  }
                                }
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                  onTap:(){
                                    if(current.length-1 == 0){
                                      print('end');
                                    }else{
                                      player.playTrackByIndex(index.data - 1);
                                    }

                                  },
                                  child: NeumorphicIcon(Icons.fast_rewind_rounded,size: 65,
                                    style: NeumorphicStyle(
                                      color: Colors.white,
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        depth: 1,
                                        lightSource: LightSource.topLeft,

                                    ),
                                  )),
                            ),
                            StreamBuilder(
                                stream: state.stream,
                                builder:(context,dat){
                                  if(dat.data == 'stopped'){
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                          onTap: (){
                                            player.playTrackByIndex(ind);
                                            setState(() {});
                                          },
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                                shape: NeumorphicShape.concave,
                                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                                                depth: 1,
                                                lightSource: LightSource.topLeft,
                                                color: img.pixelColorAtAlignment(Alignment.topCenter).withOpacity(0.5)
                                            ),
                                            child: Icon(Icons.play_arrow_rounded,size: 65,
                                            color: Colors.white,),
                                          )),
                                    );
                                  }else if(dat.data == 'playing'){
                                    return  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                          onTap: (){
                                            player.pause();
                                            setState(() {});
                                          },
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                                shape: NeumorphicShape.concave,
                                                boxShape: NeumorphicBoxShape.circle(),
                                                depth: 1,
                                                lightSource: LightSource.topLeft,
                                                color:img.pixelColorAtAlignment(Alignment.topCenter).withOpacity(0.5)
                                            ),
                                            child: Icon(Icons.pause,size: 65,
                                            color: Colors.white,),
                                          )),
                                    );
                                  }else if(dat.data == 'paused'){
                                     return  Padding(
                                       padding: const EdgeInsets.all(10.0),
                                       child: GestureDetector(
                                           onTap: (){
                                             player.play();
                                             setState(() {});
                                           },
                                           child: Neumorphic(
                                             style: NeumorphicStyle(
                                                 shape: NeumorphicShape.convex,
                                                 boxShape: NeumorphicBoxShape.circle(),
                                                 depth: 1,
                                                 lightSource: LightSource.topLeft,
                                                 color: img.pixelColorAtAlignment(Alignment.topCenter).withOpacity(0.5)
                                             ),
                                             child: Icon(Icons.play_arrow_rounded,size: 65,
                                                 color: Colors.white
                                             ),
                                           )),
                                     );
                                  }
                                  else{
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                          onTap: (){
                                            player.playTrackByIndex(ind);
                                          },
                                          child: Icon(Icons.play_arrow_rounded,size: 65,
                                          color: Colors.white,)),
                                    );
                                  }
                                }
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: (){
                                  if(current.length-1 > index.data){
                                    player.playTrackByIndex(index.data + 1);
                                  }else{
                                    print('end');
                                  }

                                },
                                  child: NeumorphicIcon(Icons.fast_forward_rounded,size: 65,
                                    style: NeumorphicStyle(
                                      color: Colors.white,
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        depth: 1,
                                        lightSource: LightSource.topLeft,

                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: Container(),
                              flex: 1,),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context)=>
                                    Lyricsong(current[ind])));
                              },
                                child: Icon(Icons.text_snippet_outlined,size: 35,
                                  color: Colors.white70,)),
                            Expanded(
                                flex: 2,
                                child: Container()),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context)=>
                                    QUe()));
                              },
                                child: Icon(Icons.playlist_play_sharp,size: 35,
                                  color: Colors.white70,)),
                            Expanded(child: Container(),
                              flex: 1,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            );

          }
          return SizedBox();
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

   lyri(BuildContext context, int data)async {
    var songgg = 'the boy boy';

    Lyrics().getLyrics(track: current[data].title,artist: current[data].artist)
        .then((value){
         print(value);
    });


   }

}
