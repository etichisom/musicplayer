import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'songm.g.dart';
@HiveType(typeId: 0)
class Songm {

  @HiveField(0)
  String albumId ;
  @HiveField(1)
  String  artistId ;
  @HiveField(2)
  String  artist ;
  @HiveField(3)
  String album;
  @HiveField(4)
  String title ;
  @HiveField(5)
  String  displayName ;
  @HiveField(6)
  String year;
  @HiveField(7)
  DateTime track ;
  @HiveField(8)
  String  duration ;
  @HiveField(9)
  String  filePath ;
  @HiveField(10)
  String  albumArtwork ;
  @HiveField(11)
  Uint8List art;
  @HiveField(12)
  String  id;
  @HiveField(13)
  DateTime dateTime;
  Songm({this.art, this.albumId, this.artistId, this.artist, this.album,
    this.title, this.displayName, this.year, this.track, this.duration,
    this.filePath, this.albumArtwork,this.id,this.dateTime});

}