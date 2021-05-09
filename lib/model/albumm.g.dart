// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albumm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbummAdapter extends TypeAdapter<Albumm> {
  @override
  final int typeId = 1;

  @override
  Albumm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Albumm(
      id: fields[0] as String,
      art: fields[1] as Uint8List,
      title: fields[2] as String,
      albumArt: fields[3] as String,
      artist: fields[4] as String,
      numberOfSongs: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Albumm obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.art)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.albumArt)
      ..writeByte(4)
      ..write(obj.artist)
      ..writeByte(5)
      ..write(obj.numberOfSongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbummAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
