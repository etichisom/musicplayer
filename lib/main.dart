import 'dart:io';
import 'dart:typed_data';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutt/app.dart';
import 'package:flutt/component/themeg.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/screen/album.dart';
import 'package:flutt/services/change.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter_plugin_playlist/flutter_plugin_playlist.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/albumm.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
     statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white70,

  ));
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(SongmAdapter());
  Hive.registerAdapter(ArtistmAdapter());
  Hive.registerAdapter(AlbummAdapter());

  runApp(Td());
}

class Td extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=>Change(),
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 2800,
        splash: 'images/d.jpg',
        nextScreen: Check(),


      ),
    );
  }
}
class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  Box<Songm> s ;
  Change p;
  BuildContext cu;
  var colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  var colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    cu = context;
    p = Provider.of<Change>(context);
    return Scaffold(
    body: SafeArea(
      child: Center(
        child: SizedBox(
        width: 250.0,
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'SLim',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'Music',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'Player',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
      ),
    ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(player.isInitialized== false){
      player.initialize();
    }

    box();
  }
  box()async{
    await Hive.openBox<Songm>('songg');
    await Hive.openBox<Albumm>('alumbb');
    await Hive.openBox<Artistm>('art');
    await  Hive.openBox('play');
    await Hive.openBox('theme');
    await Hive.openBox('ly');
    await  Hive.openBox<Songm>('his');
    s =  Hive.box<Songm>('songg');
    Box t =  Hive.box('theme');
    if(t.get('t') != null ){
      if(t.get('t')== 'dark'){setState(() {
        Get.changeTheme(dark);
        lig();
        color = Color.fromRGBO(31, 33, 32, 3);
      });
      }else{
        Get.changeTheme(light);
        dar();
        color = Colors.white10;
      }
    }
    androidInfo = await deviceInfo.androidInfo;
    if(s.length == 0){
      Box<Songm> ss = Hive.box<Songm>('songg');
      Box<Artistm> as = Hive.box<Artistm>('art');
      Box<Albumm> aa = Hive.box<Albumm>('alumbb');
      Navigator.pushReplacement(cu, MaterialPageRoute(builder: (context)=>MyHomePage()));
    }else{
      Box<Songm> ss = Hive.box<Songm>('songg');
      print(ss.length);
      Navigator.pushReplacement(cu, MaterialPageRoute(builder: (context)=>App()));

    }
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Songm> s;
  List<Albumm> ab;
  List<Artistm> arr;
  RmxAudioPlayer player = new RmxAudioPlayer();
  BuildContext cu;
  List<SongInfo> songs ;
  Change p;
  bool loading = false;
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
     p = Provider.of<Change>(context);
    cu=context;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             loading?Icon(Icons.search):NeumorphicButton(
                onPressed: (){
                 loading=true;
                 get();
                 setState(() {});
                },
                child:Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(Icons.done),
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
              SizedBox(height: 10,),
              loading==false?Text('Tap to get songs',
              style: GoogleFonts.ubuntu(
                fontSize: 15
              ),):Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('         Searching for audios this \n make take a while, grant access to storage',
                style: TextStyle(
                  fontSize: 15
                ),),
              ),
              SizedBox(height: 10,),
              loading?CircularProgressIndicator():SizedBox(),

              ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

get()async{
  Box<Songm> ss = Hive.box<Songm>('songg');
  Box<Artistm> as = Hive.box<Artistm>('art');
  Box<Albumm> aa = Hive.box<Albumm>('alumbb');
  Getsong g = Getsong();
  s= await g.getsong();
  ab = await g.getalbum();
  arr = await g.getartist();
  var cb = await g.getalbum().whenComplete(() {
    s.forEach((element) {
      ss.add(element);
    });
    ab.forEach((element) {
      aa.add(element);
    });
    arr.forEach((element) {

      as.add(element);
    });
    print('done');

    Navigator.push(cu, MaterialPageRoute(builder: (context)=>Check()));
  });




}



}



