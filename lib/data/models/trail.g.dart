// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrailAdapter extends TypeAdapter<Trail> {
  @override
  final int typeId = 1;

  @override
  Trail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trail(
      id: fields[0] as String,
      name: fields[1] as String,
      location: fields[2] as String,
      totalDistance: fields[3] as double,
      difficulty: fields[4] as String,
      estimatedSessions: fields[5] as int,
      imageUrls: (fields[6] as List).cast<String>(),
      checkpoints: (fields[7] as List).cast<Checkpoint>(),
      heroImageUrl: fields[8] as String,
      description: fields[9] as String,
      isPremium: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Trail obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.totalDistance)
      ..writeByte(4)
      ..write(obj.difficulty)
      ..writeByte(5)
      ..write(obj.estimatedSessions)
      ..writeByte(6)
      ..write(obj.imageUrls)
      ..writeByte(7)
      ..write(obj.checkpoints)
      ..writeByte(8)
      ..write(obj.heroImageUrl)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.isPremium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
