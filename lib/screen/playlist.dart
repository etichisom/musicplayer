import 'package:flutt/model/songm.dart';
import 'package:flutt/screen/playlistsong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:slate/slate.dart';

class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  Box b = Hive.box('play');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Playlist',
        style: TextStyle(

        ),),
        actions: [
          NeumorphicButton(
            onPressed: (){
              createplay(context);
            },
            child:Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(Icons.add),
            ),
            style: NeumorphicStyle(
              shape: NeumorphicShape.convex,
              depth: 1,
              color: Colors.white10,

              //border: NeumorphicBorder()
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              b.values.toList().length==0?Center(child: Text('Playlist Empty')):Expanded(
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                  children: b.values.toList().map((e){
                    return ListTile(
                      onLongPress: (){

                      },
                      onTap: (){

                      nav(context,e);
                      },
                       trailing:  PopupMenuButton(
                         itemBuilder: (BuildContext bc) => [
                           PopupMenuItem(child: Text("Delete"), value: "d"),


                         ],
                         onSelected: (route) {
                           sel(route,e);

                         },
                       ),
                      leading:
                      Slate(
                        child: Container(
                          height: 70,
                            width: 70,
                            color: Colors.white70,
                            child: Icon(Icons.album_outlined,size: 50,)),
                      ),
                      title: Text(e['name'].toString()),
                      subtitle: Text(e['d'].toString()),
                    );
                  }).toList(),
                  ),
                ),
              )
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

   createplay(BuildContext context) {
    var name = 'New';
    var desc = 'cool music';
     return showDialog(context: context, builder:(context){
       return SimpleDialog(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text('Create Playlist'),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
               onChanged: (c){
                 name=c;
               },
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 hintText: 'Name'
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextFormField(
               onChanged: (c){
                 desc =c;
               },
               decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   hintText: 'Description'
               ),
             ),
           ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: NeumorphicButton(
             onPressed: (){
               create(name,desc);
               Navigator.pop(context);
             },
             child: Center(child: Text('Create')),
             style: NeumorphicStyle(
               depth: 1,
               color: Colors.green
             ),
           ),
         )
         ],
       );
     });
   }

   create(String name, String desc) {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    b.put(id, {
      'name':name,
      'd':desc,
      'id':id
    });
    setState(() {});
   }

   nav(BuildContext context, Map e)async {
    await Hive.openBox<Songm>(e['id']);
     print(e['id']);
     Navigator.push(context, MaterialPageRoute(builder:(context)=>Psong(e)));
   }

   sel(route, e) {
    b.delete(e['id']);
    setState(() {});
   }
}
