import 'dart:io';
import 'dart:typed_data';
import 'package:flutt/screen/his.dart';
import 'package:flutter/painting.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutt/component/songtile.dart';
import 'package:flutt/component/themeg.dart';
import 'package:flutt/model/albumm.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/screen/albumsong.dart';
import 'package:flutt/screen/artsong.dart';
import 'package:flutt/screen/history.dart';
import 'package:flutt/screen/last%20added.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

import '../app.dart';
import '../main.dart';
import 'idsong.dart';

class Broe extends StatefulWidget {
  @override
  _BroeState createState() => _BroeState();
}

class _BroeState extends State<Broe> {
  List<ArtistInfo> al =[];
  List<AlbumInfo> a =[];
  Box<Songm> ss = Hive.box<Songm>('songg');
  Box<Artistm> as = Hive.box<Artistm>('art');
  Box<Albumm> aa = Hive.box<Albumm>('alumbb');
  Box<Songm> s = Hive.box('his');
  List<Songm> i;
  Box<Songm> h = Hive.box('his');
  final key = GlobalKey<ScaffoldState>();
  Box t =  Hive.box('theme');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: Drawer(
        child: Scaffold(
          body: ListView(
            children: [
              SizedBox(height: 20,),
             Container(
               height: 150,
               width: MediaQuery.of(context).size.width,
               child: Column(
                 children: [
                   Container(
                     height: 100,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         image: AssetImage('images/d.jpg'),
                         fit: BoxFit.scaleDown
                       )
                     ),
                   ),
                   Expanded(child: Container()),
                   Container(
                     width:MediaQuery.of(context).size.width,
                     child: Center(
                       child: Text('SLIMPLAYER',style: GoogleFonts.abel(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.grey
                       ),
                     ),
                   )
                   )

                 ],
               ),
             ),
              SizedBox(height: 40,),
              Divider(
                thickness: 3,
              ),
              ListTile(
                onTap: (){
                  refresh(context);
                },
                title: Text('Refresh'),
                leading: Icon(Icons.refresh),
                subtitle: Text('Refresh to get newly added song'),
              ), ListTile(
                onTap: (){about(context);},
                title: Text('About'),
                leading: Icon(Icons.info_outline,),
                subtitle: Text('About SlimPlayer'),
              ),
              ListTile(
                onTap: (){
                  changet(context);

                },
                title: Text('Theme'),
                leading: Icon(Icons.color_lens_sharp,),
                subtitle: Text('Change App Theme'),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 20,top: 5,bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                    onPressed: (){
                      key.currentState.openDrawer();
                    },
                    child:Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.menu),
                    ),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      depth: 1,
                      color:color,
                      boxShape:
                      NeumorphicBoxShape.circle(),
                      //border: NeumorphicBorder()
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: Center(
                        child: NeumorphicText(
                          "SLimplayer",
                          style: NeumorphicStyle(
                            depth: 1,  //customize depth here
                            color: Colors.grey, //customize color here
                          ),textStyle: NeumorphicTextStyle(
                          fontSize: 18, //// customize size here
                          // AND others usual text style properties (fontFamily, fontWeight, ...)
                        ),
                        ),
                      ),
                    ),
                  ),

                  NeumorphicButton(
                    onPressed: (){
                      nev(context);

                    },
                    child:Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(Icons.mic),
                    ),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      depth: 1,
                      color: color,
                      boxShape:
                      NeumorphicBoxShape.circle(),

                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(leading: Container(
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           border: Border.all(color: Colors.purple)
                         ),
                           child: Icon(Icons.person_outlined,color: Colors.purple,size: 40,)),
                       title: Text('Welcome'),
                       subtitle:t.get('user')==null?Text('User'):Text(t.get('user').toString()),
                        trailing: GestureDetector(
                          onTap: (){
                            d(context);
                          },
                            child: Icon(Icons.edit)),
                     ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, PageTransition(type: PageTransitionType.scale,
                                    alignment: Alignment.center, child:His()));
                              },
                              child: Column(
                                children: [
                                  GestureDetector(
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: Colors.blue.withOpacity(0.5),
                                      child: Icon(Icons.history),
                                    ),
                                    onTap: (){
                                      Navigator.push(context, PageTransition(type: PageTransitionType.scale,
                                          alignment: Alignment.center, child:Hist()));
                                    },
                                  ),
                                  SizedBox(height: 5,),
                                  Text('History',
                                      style:TextStyle(
                                          color: Colors.grey
                                      ))
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Column(
                              children: [
                                GestureDetector(
                                  child: CircleAvatar(
                                    radius: 23,
                                    backgroundColor: Colors.red.withOpacity(0.5),
                                    child: Icon(Icons.add_to_photos_rounded),
                                  ),
                                  onTap: (){
                                    Navigator.push(context, PageTransition(type: PageTransitionType.scale,
                                        alignment: Alignment.topRight, child:Songl(i)));
                                  },
                                ),
                                SizedBox(height: 5,),
                                Text('Last Added',
                                    style:TextStyle(
                                        color: Colors.grey
                                    ))
                              ],
                            ),
                            Expanded(child: Container()),

                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Box<Songm> s =Hive.box<Songm>('songg');
                                    List<Songm> f= s.values.toList();
                                    f.shuffle();
                                    print(s.values.length);
                                    playsong(f, 0).play();
                                  },
                                  child: CircleAvatar(
                                    radius: 23,
                                    backgroundColor: Colors.green.withOpacity(0.7),
                                    child: Icon(Icons.shuffle),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text('Shuffle',
                                    style:TextStyle(
                                        color: Colors.grey
                                    ))
                              ],
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      as.length==0?SizedBox():Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Top Artist',
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            color: Colors.grey
                          ),),
                      ),
                      as.length==0?SizedBox(): Container(
                        height: 190,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children:as.values.toList().map((e){
                            if(as.values.toList().indexOf(e) > 6){
                              return SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 190,
                                width: 140,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundImage: androidInfo.version.sdkInt >=29?
                                        e.art.length<1?AssetImage('images/d.jpg') :MemoryImage(e.art):
                                        e.artistArtPath!=null ? FileImage(File(e.artistArtPath)):
                                        AssetImage('images/d.jpg'),
                                      ),
                                      onTap: (){
                                        Navigator.push(context, PageTransition(type: PageTransitionType.scale,
                                            alignment: Alignment.center, child:ArtSOng(e)));

                                      },
                                    ),
                                    Text(e.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,)
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      aa.length==0?SizedBox():Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Top Album',
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.grey
                          ),),
                      ),
                      aa.length==0?SizedBox(): Container(
                        height: 200,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children:aa.values.toList().map((e){
                            if(aa.values.toList().indexOf(e) > 6){
                              return SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                width: 150,
                                child: Column(
                                  children: [
                                    PhysicalModel(
                                      child: GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image:androidInfo.version.sdkInt >=29?
                                                  e.art.length<1?AssetImage('images/d.jpg') :MemoryImage(e.art):
                                                  e.albumArt!=null ? FileImage(File(e.albumArt)):
                                                  AssetImage('images/d.jpg'),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                          height:150,
                                          width: 150,
                                        ),
                                        onTap: (){
                                          Navigator.push(context, PageTransition(type: PageTransitionType.scale,
                                              alignment: Alignment.center, child:Albumsong(e,1)));
                                        },
                                      ),
                                      color: Colors.black,
                                      elevation: 5,
                                      borderRadius:BorderRadius.circular(10) ,
                                    ),
                                    Text(e.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,)
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                     s.length==0?SizedBox():  Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text('Recently Played',
                             style: GoogleFonts.ubuntu(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 24,
                                 color: Colors.grey
                             ),),
                           Icon(Icons.history,
                           color: Colors.grey[400],)
                         ],
                       ),
                     ),
                      s.length==0?SizedBox():Container(
                        height: 200,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children:s.values.toList().map((e){
                            int index = s.values.toList().reversed.toList().indexOf(e);
                            if(s.values.toList().indexOf(e) > 6){
                              return SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                width: 130,
                                child: Column(
                                  children: [
                                    PhysicalModel(
                                      child: GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image:androidInfo.version.sdkInt >=29?
                                                  e.art.length<1?AssetImage('images/d.jpg') :MemoryImage(e.art):
                                                  e.albumArtwork!=null ? FileImage(File(e.albumArtwork)):
                                                  AssetImage('images/d.jpg'),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                          height:130,
                                          width: 130,
                                        ),
                                        onTap: (){
                                          playsong(s.values.toList().reversed.toList(), index).play();
                                          setState(() {});
                                        },
                                      ),
                                      color: Colors.black,
                                      elevation: 5,
                                      borderRadius:BorderRadius.circular(10) ,
                                    ),
                                    Text(e.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,)
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  gr()async{
     a = await  audioQuery.getAlbums(sortType: AlbumSortType.MORE_SONGS_NUMBER_FIRST);
     al = await  audioQuery.getArtists(sortType: ArtistSortType.MORE_TRACKS_NUMBER_FIRST);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gr();
    i = ss.values.toList();

  }

 Widget b(AlbumInfo e, BuildContext context, String a) {
    return FutureBuilder<Uint8List>(
      future: audioQuery.getArtwork(type:ResourceType.ALBUM, id:e.id),
        builder: (context,snap){
        if(snap.data != null){
          return Image.memory(snap.data,fit: BoxFit.cover,);
        }else{
          return Text('p');
        }
        }
    );
 }
  about(BuildContext context){
    return showAboutDialog(context: context,applicationIcon:Icon(Icons.music_note),
        applicationName: "SLimPlayer",applicationVersion: '1.0.0',
        children:[
          Text('A Music player built with flutter')
        ]);
  }

  nev(BuildContext context)async{
    await Hive.openBox<Songm>('id');
    Navigator.push(cuu, PageTransition(type: PageTransitionType.scale,
        alignment: Alignment.topRight, child:Id()));
  }

  changet(BuildContext context) {

    Box v = Hive.box('theme');
    return showDialog(context: context,
        builder:(context){
          return SimpleDialog(
            children: [
              ListTile(
                title: Text('Light theme'),
                leading: Icon(Icons.brightness_5_rounded),
                onTap: (){
                  v.put('t', 'light');
                  Get.changeTheme(light);
                  dar();
                  color = Colors.white10;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              ListTile(
                title: Text('Dark theme'),
                leading: Icon(Icons.brightness_2_rounded),
                onTap: (){
                  v.put('t', 'dark');
                  Get.changeTheme(dark);
                  lig();
                  color = Color.fromRGBO(31, 33, 32, 1);
                  Navigator.pop(context);
                  setState(() {});
                },
              )
            ],
          );
        }
    );
  }
  refresh(BuildContext context) async{
    Box<Songm> ss = Hive.box<Songm>('songg');
    Box<Artistm> as = Hive.box<Artistm>('art');
    Box<Albumm> aa = Hive.box<Albumm>('alumbb');
    await ss.clear();
    await as.clear();
    await aa.clear();

    Navigator.pushReplacement(cuu, MaterialPageRoute(builder: (context)=>Check()));

  }

   d(BuildContext context) {
    var u = 'user';
    return showDialog(context: context, builder:(context){
      return SimpleDialog(
        children: [
          Center(
            child: Text('Enter name',style:GoogleFonts.ubuntu(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (v){
                u=v;
              },
            ),
          ),
          SizedBox(height: 7,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.green,
              onPressed: (){
                t.put('user', u);
                Navigator.pop(context);
                setState(() {});
              },
            child: Text("Ok",
            style: TextStyle(color: Colors.white),),),
          )
        ],
      );
    });
   }

}
