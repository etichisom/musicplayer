import 'dart:io';
import 'dart:math';

import 'package:flutt/component/bottom.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter_plugin_playlist/flutter_plugin_playlist.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:slate/slate.dart';

class QUe extends StatefulWidget {
  @override
  _QUeState createState() => _QUeState();
}

class _QUeState extends State<QUe> {
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      body:  StreamBuilder(
        stream: cindex.stream,
        builder:(context,d){
          if(d.data != null){
            return ImagePixels(imageProvider:androidInfo.version.sdkInt >=29?
            current[d.data].art.length<1?AssetImage('images/d.jpg') :MemoryImage(current[d.data].art):
            current[d.data].albumArtwork!=null ? FileImage(File(current[d.data].albumArtwork)):
            AssetImage('images/d.jpg'),
                defaultColor: Colors.grey,
                builder: (context, i){
                  return Container(
                    decoration: BoxDecoration(
                        gradient:LinearGradient(
                            colors: [
                              i.pixelColorAtAlignment(Alignment.bottomCenter).withOpacity(0.5),
                              i.pixelColorAtAlignment(Alignment.topCenter).withOpacity(0.5)
                            ]
                        )
                    ),
                    height: size.height,
                    width: size.width,
                    child: SafeArea(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Slate(
                              child: Hero(
                                tag: 'tag',
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.deepOrangeAccent,
                                      image: DecorationImage(
                                          image:androidInfo.version.sdkInt >=29?
                                          current[d.data].art.length<1?AssetImage('images/d.jpg') :MemoryImage(current[d.data].art):
                                          current[d.data].albumArtwork!=null ? FileImage(File(current[d.data].albumArtwork)):
                                          AssetImage('images/d.jpg'),
                                          fit: BoxFit.cover
                                      )
                                  ),),
                              ),
                            ),
                            title:  Text(
                              current[d.data].displayName,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            subtitle:  Text(
                              current[d.data].artist,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            trailing: GestureDetector(
                              child: Icon(Icons.more_vert),
                              onTap: (){
                                Bottom(e: current[d.data]).but();
                              },),
                          ),
                       ListTile(
                        title: Text('Playing Next'),

                      ),
                      Expanded(child:Container(
                        child:ListView(
                          children:current.map((e){
                            var i = current.indexOf(e);
                            if(d.data >= i){
                              return SizedBox(

                              );
                            }
                            return   ListTile(

                              onTap: (){
                                player.playTrackByIndex(i);
                              },
                              leading: Slate(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.deepOrangeAccent,
                                      image: DecorationImage(
                                          image:androidInfo.version.sdkInt >=29?
                                          e.art.length<1?AssetImage('images/d.jpg'):
                                          MemoryImage(e.art):
                                          e.albumArtwork!=null ?FileImage(File(e.albumArtwork)):
                                          AssetImage('images/d.jpg'),
                                          fit: BoxFit.cover
                                      )
                                  ),),
                              ),
                              title:  Text(
                                e.title,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                              trailing: GestureDetector(
                                onTap: (){
                                  var i  = current.indexOf(e);
                                  player.removeItem(AudioTrackRemoval(
                                    trackIndex: i,trackId: e.id
                                  )).then((value){
                                    current.removeAt(i);
                                    setState(() {});
                                  });
                                },
                                  child: Icon(Icons.clear)),
                              subtitle:  Text(
                                e.artist,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),

                            );
                          }).toList(),
                        ),
                      )),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                                child: Icon(Icons.flip_to_back_sharp,size: 50,)),
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          }else{
            return SizedBox();
          }
        },
      ),
    );
  }

   order(int old, int news) {
   var a =  AudioTrack(
       album: current[old].album,
       artist: current[old].artist,
       assetUrl: current[old].filePath,
       title: current[old].title,
       isStream: false,


     );
     if(news > old){
       news = news-1;
     }
     var s = player.removeItem(AudioTrackRemoval(trackIndex:old));
     var ss = current.removeAt(old);
     player.addItem(a);
     current.add(ss);
     setState(() {});

   }
}
