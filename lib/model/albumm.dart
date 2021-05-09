import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'albumm.g.dart';
@HiveType(typeId: 1)
class Albumm  {
  @HiveField(0)
  String id;
  @HiveField(1)
  Uint8List art;
  @HiveField(2)
  String  title;
  @HiveField(3)
  String  albumArt ;
  @HiveField(4)
  String  artist ;
  @HiveField(5)
  String  numberOfSongs ;

  Albumm({this.id, this.art, this.title, this.albumArt, this.artist,
      this.numberOfSongs});
}