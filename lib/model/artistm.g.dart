// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artistm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtistmAdapter extends TypeAdapter<Artistm> {
  @override
  final int typeId = 2;

  @override
  Artistm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artistm(
      id: fields[0] as String,
      art: fields[1] as Uint8List,
      name: fields[2] as String,
      numberOfTrack: fields[3] as String,
      numberOfAlbums: fields[4] as String,
      artistArtPath: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Artistm obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.art)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.numberOfTrack)
      ..writeByte(4)
      ..write(obj.numberOfAlbums)
      ..writeByte(5)
      ..write(obj.artistArtPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistmAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
