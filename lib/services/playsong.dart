import 'dart:io';

import 'package:flutt/model/songm.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutter_plugin_playlist/flutter_plugin_playlist.dart';
List<Songm> current = [];
RmxAudioPlayer player = new RmxAudioPlayer();

class playsong{
  List<Songm> songm;
  int index;

  playsong(this.songm, this.index);
  play()async{
    current=[];
    songm.forEach((element) {
      current.add(element);
    });
  List<AudioTrack> track =[];
  current.forEach((element) {
    track.add(AudioTrack(
        album: element.album,
        artist: element.artist,
        assetUrl: element.filePath,
        albumArt: element.albumArtwork,
        title: element.title,
        trackId: element.id,
        isStream: false,


    ),);
  });

   await player.setPlaylistItems(track,
       options: new PlaylistItemOptions(
           startPaused: true,
       ));
   await player.playTrackByIndex(index);
    await player.setLoop(true);

  }

}