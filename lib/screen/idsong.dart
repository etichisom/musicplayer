import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/screen/identify.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Id extends StatefulWidget {
  @override
  _IdState createState() => _IdState();
}

class _IdState extends State<Id> {
  final AcrCloudSdk arc = AcrCloudSdk();
  bool r = false;
  var ra = 60.0;
  var ind = 0;
  List<int> l = [0,1];
  Music music;
  final key = GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:l.map((e){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor:e==ind?Colors.red:Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: Container(
                child: PageView(
                  onPageChanged: (v){
                    setState(() {
                      ind=v;
                    });
                  },
                  children: [
                    Column(
                      children: [
                        Text('Identify Music',
                        style:GoogleFonts.ubuntuMono(
                          fontSize: 24
                        )),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: (){
                           if(r == true){
                             music=null;
                             arc.stop();
                             setState(() {
                               r = false;
                               ra =60;
                             });
                           }else{
                             arc.start().catchError((e){print(e);
                             arc.stop();
                             music=null;
                             reduce();
                             }).whenComplete(() =>print('cccccc'));
                             setState(() {
                               r =true;
                               ra = 90;
                             });
                           }
                          },
                          child: AvatarGlow(
                            animate: r,
                            glowColor: Colors.blue[800],
                            endRadius: 200.0,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height:ra,
                              width:ra,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 2,
                                    spreadRadius: 2
                                  ),
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      spreadRadius: 2
                                  )
                                ],
                                color: Colors.blue,

                                shape: BoxShape.circle
                              ),

                           child:Center(child:r?Icon(Icons.mic_off):Icon(Icons.mic)),
                            ),
                          ),
                        ),
                        Expanded(child: Container(
                          child: Stack(
                            children: [
                              music==null?SizedBox():r==false?Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                 decoration: BoxDecoration(
                                     color: Colors.white,
                                   borderRadius: BorderRadius.only(
                                     topLeft: Radius.circular(20),
                                     topRight: Radius.circular(20)
                                   )
                                 ),
                                  child:  Column(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.music_note,
                                        color: Colors.red,),
                                        title: Text(music.title,
                                        style: TextStyle(color: Colors.black),),
                                        subtitle: Text(music.artists[0].name,
                                          style: TextStyle(color: Colors.grey),),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.album,color: Colors.red,),
                                        title: Text('Album : ' + music.album.name,
                                          style: TextStyle(color: Colors.black),),
                                        subtitle: Text('Release date : ' + music.releaseDate,
                                          style: TextStyle(color: Colors.grey[600]),),
                                      ),

                                    ],
                                  ),
                                ),
                              ):SizedBox(),
                            ],
                          ),
                        )),


                      ],
                    ),
                    Container(
                      color: Colors.red,
                      child: Identify(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arc..init(
      host: 'identify-eu-west-1.acrcloud.com', // obtain from https://www.acrcloud.com/
      accessKey: '56d6bedae3a667f236d83203ecbd75f0', // obtain from https://www.acrcloud.com/
      accessSecret: 'nqJQsHYpPdvtdHXjTfzs7DceX2gvdiCJkOrvEB6h', // obtain from https://www.acrcloud.com/
      setLog: false,
    )..songModelStream.listen((event) {
      if(event.metadata.music.length >0){
        music  =event.metadata.music[0];
        reduce();
        Box<Songm> b = Hive.box('id');
        b.put(music.title,Songm(title:music.title,
        artist:music.artists[0].name.toString()));
        arc.stop();
      }else{
        arc.stop();
      }
    }).onError((e){
      arc.stop();
    })..stop();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    arc.stop();
  }
  reduce(){
    setState(() {
      r = false;
      ra =60;
    });
  }
}
