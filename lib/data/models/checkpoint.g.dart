// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpoint.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckpointAdapter extends TypeAdapter<Checkpoint> {
  @override
  final int typeId = 0;

  @override
  Checkpoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Checkpoint(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      distanceFromStart: fields[3] as double,
      imageUrl: fields[4] as String,
      educationalFact: fields[5] as String,
      isUnlocked: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Checkpoint obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.distanceFromStart)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.educationalFact)
      ..writeByte(6)
      ..write(obj.isUnlocked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckpointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
