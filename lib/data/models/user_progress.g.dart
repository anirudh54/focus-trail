// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProgressAdapter extends TypeAdapter<UserProgress> {
  @override
  final int typeId = 2;

  @override
  UserProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProgress(
      trailId: fields[0] as String,
      currentDistance: fields[1] as double,
      totalSessions: fields[2] as int,
      unlockedCheckpoints: (fields[3] as List).cast<String>(),
      lastSessionDate: fields[5] as DateTime,
      isCompleted: fields[4] as bool,
      collectedStamps: (fields[6] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProgress obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.trailId)
      ..writeByte(1)
      ..write(obj.currentDistance)
      ..writeByte(2)
      ..write(obj.totalSessions)
      ..writeByte(3)
      ..write(obj.unlockedCheckpoints)
      ..writeByte(4)
      ..write(obj.isCompleted)
      ..writeByte(5)
      ..write(obj.lastSessionDate)
      ..writeByte(6)
      ..write(obj.collectedStamps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
