
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:flutt/model/albumm.dart';
import 'package:flutt/model/artistm.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
class Controller extends GetxController{
  var count = 5.obs;
  increment(var i) => count=i;
}

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
StreamController<int> cindex = new BehaviorSubject<int>();
StreamController<int> cdua = new BehaviorSubject<int>();
StreamController<String> state = new BehaviorSubject<String>();
StreamController<int> cp = new BehaviorSubject<int>();


AndroidDeviceInfo androidInfo ;
List<Songm> gsongs = [];
List<Artistm> gartists = [];
List<Albumm> galbums = [];
List<Songm> songs = [];
List<Artistm> artists = [];
List<Albumm> albums = [];
List<Songm> songss = [];
FlutterAudioQuery audioQuery = FlutterAudioQuery();
double seeking;
double position = 0;

int currents = 0;
int total = 0;

class Getsong {

  Future<List<Songm>> getsong()async{
    songs = [];
   List<SongInfo> songinfo = await audioQuery.getSongs();
     if(androidInfo.version.sdkInt>= 29){
        songinfo.forEach((element)async {
          DateTime d;
          try{
            d = File(element.filePath).lastAccessedSync();
          }catch(e){
            d = DateTime(2000);
          }
         Uint8List artwork = await audioQuery.getArtwork(type:ResourceType.SONG, id:element.id);
         Directory documentDirectory = await  getExternalStorageDirectory();
         File file = new File(documentDirectory.path + element.title + '.png');
           File path;
           if(artwork.length != 0) {
             path = await file.writeAsBytes(artwork);
           }
         songs.add(Songm(
          album: element.album,
          artist: element.artist,
          title: element.title, albumArtwork:artwork.length ==0?null:path.path,
          albumId: element.albumId,
          art: artwork,
          filePath: element.filePath,
          displayName: element.displayName,
          artistId: element.artistId,
          id: element.id,
          duration: element.duration,
          track: d,
          year: element.year,
             dateTime: d
         ));


        });
     }else{
      songinfo.forEach((element)async {
        DateTime d;
        try{
           d = File(element.filePath).lastAccessedSync();
        }catch(e){
          d = DateTime(2000);
        }

       songs.add(Songm(
           album: element.album,
           artist: element.artist,
           title: element.title,
           albumArtwork: element.albumArtwork,
           albumId: element.albumId,
           art:null,
           id: element.id,
           filePath: element.filePath,
           displayName: element.displayName,
           artistId: element.artistId,
           duration: element.duration,
           track: d,
           year: element.year,
           dateTime: d

       ));

      });
     }
     
     return songs;
  }
 Future<List<Artistm>> getartist()async{
    artists=[];
   List<ArtistInfo> artist = await audioQuery.getArtists(sortType: ArtistSortType.MORE_TRACKS_NUMBER_FIRST);
   if(androidInfo.version.sdkInt>= 29){
    artist.forEach((element)async {
     Uint8List artwork = await audioQuery.getArtwork(type:ResourceType.ARTIST, id:element.id);
     artists.add(Artistm(
      id: element.id,
      numberOfAlbums: element.numberOfTracks,
      art: artwork,
      numberOfTrack: element.numberOfTracks,
      artistArtPath: element.artistArtPath,
      name: element.name
     ));
    });
   }else{
    artist.forEach((element)async {
     artists.add(Artistm(
         id: element.id,
         numberOfAlbums: element.numberOfTracks,
         art: null,
         numberOfTrack: element.numberOfTracks,
         artistArtPath: element.artistArtPath,
         name: element.name
     ));
    });
   }
   return artists;
  }
  Future<List<Albumm>> getalbum()async{
    albums = [];
   List<AlbumInfo> albumList = await audioQuery.getAlbums(sortType: AlbumSortType.MORE_SONGS_NUMBER_FIRST);
   if(androidInfo.version.sdkInt>= 29){
    albumList.forEach((element)async {
     Uint8List artwork = await audioQuery.getArtwork(type:ResourceType.ALBUM, id:element.id);
     albums.add(
      Albumm(
       id: element.id,
       art: artwork,
       artist: element.artist,
       albumArt: element.albumArt,
       numberOfSongs: element.numberOfSongs,
       title: element.title
      )
     );

    });

   }else{
    albumList.forEach((element)async {
     albums.add(
         Albumm(
             id: element.id,
             art: null,
             artist: element.artist,
             albumArt: element.albumArt,
             numberOfSongs: element.numberOfSongs,
             title: element.title
         )
     );

    });
   }
   return albums;
  }

 }