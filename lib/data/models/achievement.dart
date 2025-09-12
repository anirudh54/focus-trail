import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'achievement.g.dart';

@HiveType(typeId: 5)
class Achievement extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final String iconPath;
  
  @HiveField(4)
  final AchievementCategory category;
  
  @HiveField(5)
  final bool isUnlocked;
  
  @HiveField(6)
  final DateTime? unlockedAt;
  
  @HiveField(7)
  final Map<String, dynamic> criteria;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.category,
    required this.criteria,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? iconPath,
    AchievementCategory? category,
    bool? isUnlocked,
    DateTime? unlockedAt,
    Map<String, dynamic>? criteria,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconPath: iconPath ?? this.iconPath,
      category: category ?? this.category,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      criteria: criteria ?? this.criteria,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        iconPath,
        category,
        isUnlocked,
        unlockedAt,
        criteria,
      ];
}

@HiveType(typeId: 6)
enum AchievementCategory {
  @HiveField(0)
  distance,
  
  @HiveField(1)
  consistency,
  
  @HiveField(2)
  trailCompletion,
  
  @HiveField(3)
  special,
}