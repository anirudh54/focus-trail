// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionRecordAdapter extends TypeAdapter<SessionRecord> {
  @override
  final int typeId = 3;

  @override
  SessionRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionRecord(
      date: fields[0] as DateTime,
      focusMinutes: fields[1] as int,
      distance: fields[2] as double,
      tasksCompleted: fields[3] as int,
      trailId: fields[4] as String,
      sessionType: fields[5] as String,
      wasSuccessful: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SessionRecord obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.focusMinutes)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.tasksCompleted)
      ..writeByte(4)
      ..write(obj.trailId)
      ..writeByte(5)
      ..write(obj.sessionType)
      ..writeByte(6)
      ..write(obj.wasSuccessful);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
