import 'package:flutt/model/albumm.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutter/cupertino.dart';

class Change extends ChangeNotifier{
  List<Songm> songs = [];
  List<Songm> songss = [];
  List<Artistm> artists = [];
  List<Songm> songp = [];
  List<Albumm> albums = [];
  int c = 0;
  int postion = 0;




  setsong(List<Songm> song){
    songs=song;
    notifyListeners();
  }
  setsonp(List<Songm> s){
    songp=s;
    notifyListeners();
  }
  setint(int song){
    c=song;
    notifyListeners();
  }
  setp(int song){
    postion=song;
    notifyListeners();
  }
  setsongs(List<Songm> son){
    songss=son;
    notifyListeners();
  }
  setalbum(List<Albumm> al){
    albums=al;
    notifyListeners();
  }
  List<Songm> getasong(){
    return songss;
  }
 setart(List<Artistm> a){
    artists =a;
    notifyListeners();
 }
}