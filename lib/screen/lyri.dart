import 'dart:io';

import 'package:flutt/model/songm.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:lyrics/lyrics.dart';
import 'package:slate/slate.dart';


class Lyricsong extends StatefulWidget {
  Songm m;

  Lyricsong(this.m);

  @override
  _LyricsongState createState() => _LyricsongState();
}

class _LyricsongState extends State<Lyricsong> {
  Size size;
  String g;
  bool show = true;
  Box b = Hive.box('ly');
  final key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: key,
      backgroundColor: Colors.brown,
      body: StreamBuilder(
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
                height: size.height,
                decoration: BoxDecoration(
                    gradient:LinearGradient(
                        colors: [
                          i.pixelColorAtAlignment(Alignment.bottomCenter).withOpacity(0.5),
                          i.pixelColorAtAlignment(Alignment.topCenter).withOpacity(0.5)
                        ]
                    )
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      ListTile(
                        trailing: GestureDetector(
                          onTap: (){
                            lyri();
                          },
                            child: Icon(Icons.refresh)),
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
                      ),
                     b.get(current[d.data].title)!= null?
                         ll( b.get(current[d.data].title).toString()):show?
                     Expanded(child: Container(child: Center(child: CircularProgressIndicator()))):Expanded(
                        child: Container(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  g,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.flip_to_back_sharp,size: 40,color: Colors.white,)),
                          ),
                         b.get(current[d.data].title)==null?Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                                onTap: (){
                                 if(g != 'Lyrics not found'){
                                   b.put(current[d.data].title, g);
                                  toast('Saves',Colors.green);
                                  setState(() {});
                                 }else{
                                   toast('Lyrics not found',Colors.red);
                                 }
                                },
                                child: Icon(Icons.save_alt,size: 40,color: Colors.white,)),
                          ):Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: GestureDetector(
                               onTap: (){
                                 b.delete(current[d.data].title);
                                 toast('Lyrics deleted',Colors.red);
                                 lyri();
                               },
                               child: Icon(Icons.delete,size: 40,color: Colors.white,)),
                         ),
                        ],
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

   lyri(){
    show = true;
    setState(() {
      g = "Searching for lrics";
    });
    Lyrics().getLyrics(artist:player.currentTrack.artist, track: player.currentTrack.title)
        .then((value){
          if(mounted){
            setState(() {
              g=value;
              show=false;
            });
          }

    }).onError((error, stackTrace){
      setState(() {
        g = 'Lyrics not found';
        show=false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lyri();
  
  }
  lyri2(){

    Lyrics().getLyrics(artist: player.currentTrack.artist, track: player.currentTrack.title)
        .then((value){
      if(mounted){
        print(g);
        setState(() {
          g=value;
        });
      }

    });
}
  Widget ll(String i){
    return Expanded(
      child: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                i,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
toast(String mess, Color c){
    key.currentState.showSnackBar(SnackBar(content:Text(mess,
    style: TextStyle(
      color: Colors.white
    ),),duration: Duration(microseconds:700),
    backgroundColor: c,));
}
}
