// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AchievementAdapter extends TypeAdapter<Achievement> {
  @override
  final int typeId = 5;

  @override
  Achievement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Achievement(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      iconPath: fields[3] as String,
      category: fields[4] as AchievementCategory,
      criteria: (fields[7] as Map).cast<String, dynamic>(),
      isUnlocked: fields[5] as bool,
      unlockedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Achievement obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.iconPath)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.isUnlocked)
      ..writeByte(6)
      ..write(obj.unlockedAt)
      ..writeByte(7)
      ..write(obj.criteria);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AchievementCategoryAdapter extends TypeAdapter<AchievementCategory> {
  @override
  final int typeId = 6;

  @override
  AchievementCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AchievementCategory.distance;
      case 1:
        return AchievementCategory.consistency;
      case 2:
        return AchievementCategory.trailCompletion;
      case 3:
        return AchievementCategory.special;
      default:
        return AchievementCategory.distance;
    }
  }

  @override
  void write(BinaryWriter writer, AchievementCategory obj) {
    switch (obj) {
      case AchievementCategory.distance:
        writer.writeByte(0);
        break;
      case AchievementCategory.consistency:
        writer.writeByte(1);
        break;
      case AchievementCategory.trailCompletion:
        writer.writeByte(2);
        break;
      case AchievementCategory.special:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
