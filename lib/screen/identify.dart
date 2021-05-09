import 'package:flutt/model/songm.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Identify extends StatefulWidget {
  @override
  _IdentifyState createState() => _IdentifyState();
}

class _IdentifyState extends State<Identify> {
  Box<Songm> v = Hive.box('id');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Recent Recognized',
            style: GoogleFonts.ubuntu(
              fontSize: 18,
            ),),
          ),
          Divider(thickness: 2,),
          Expanded(
            child: Container(
              child: ListView(
                children: v.values.toList().map((e){
                  return ListTile(
                    leading: Icon(Icons.mic),
                    title: Text(e.title.toString()),
                    subtitle: Text(e.artist.toString()),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      )),
    );
  }

}
