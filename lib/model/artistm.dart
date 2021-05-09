import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'artistm.g.dart';
@HiveType(typeId: 2)
class Artistm  {
  @HiveField(0)
  String id;
  @HiveField(1)
  Uint8List art;
  @HiveField(2)
  String name ;
  @HiveField(3)
  String  numberOfTrack;
  @HiveField(4)
  String numberOfAlbums;
  @HiveField(5)
  String  artistArtPath ;

  Artistm({this.id, this.art, this.name, this.numberOfTrack, this.numberOfAlbums,
      this.artistArtPath});
}