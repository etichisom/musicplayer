// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongmAdapter extends TypeAdapter<Songm> {
  @override
  final int typeId = 0;

  @override
  Songm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Songm(
      art: fields[11] as Uint8List,
      albumId: fields[0] as String,
      artistId: fields[1] as String,
      artist: fields[2] as String,
      album: fields[3] as String,
      title: fields[4] as String,
      displayName: fields[5] as String,
      year: fields[6] as String,
      track: fields[7] as DateTime,
      duration: fields[8] as String,
      filePath: fields[9] as String,
      albumArtwork: fields[10] as String,
      id: fields[12] as String,
        dateTime: fields[13] as DateTime
    );
  }

  @override
  void write(BinaryWriter writer, Songm obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.albumId)
      ..writeByte(1)
      ..write(obj.artistId)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.displayName)
      ..writeByte(6)
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.track)
      ..writeByte(8)
      ..write(obj.duration)
      ..writeByte(9)
      ..write(obj.filePath)
      ..writeByte(10)
      ..write(obj.albumArtwork)
      ..writeByte(11)
      ..write(obj.art);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
