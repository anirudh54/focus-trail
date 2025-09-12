import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'user_progress.g.dart';

@HiveType(typeId: 2)
class UserProgress extends Equatable {
  @HiveField(0)
  final String trailId;
  
  @HiveField(1)
  final double currentDistance;
  
  @HiveField(2)
  final int totalSessions;
  
  @HiveField(3)
  final List<String> unlockedCheckpoints;
  
  @HiveField(4)
  final bool isCompleted;
  
  @HiveField(5)
  final DateTime lastSessionDate;
  
  @HiveField(6)
  final List<String> collectedStamps;

  const UserProgress({
    required this.trailId,
    required this.currentDistance,
    required this.totalSessions,
    required this.unlockedCheckpoints,
    required this.lastSessionDate,
    this.isCompleted = false,
    this.collectedStamps = const [],
  });

  UserProgress copyWith({
    String? trailId,
    double? currentDistance,
    int? totalSessions,
    List<String>? unlockedCheckpoints,
    bool? isCompleted,
    DateTime? lastSessionDate,
    List<String>? collectedStamps,
  }) {
    return UserProgress(
      trailId: trailId ?? this.trailId,
      currentDistance: currentDistance ?? this.currentDistance,
      totalSessions: totalSessions ?? this.totalSessions,
      unlockedCheckpoints: unlockedCheckpoints ?? this.unlockedCheckpoints,
      isCompleted: isCompleted ?? this.isCompleted,
      lastSessionDate: lastSessionDate ?? this.lastSessionDate,
      collectedStamps: collectedStamps ?? this.collectedStamps,
    );
  }

  @override
  List<Object?> get props => [
        trailId,
        currentDistance,
        totalSessions,
        unlockedCheckpoints,
        isCompleted,
        lastSessionDate,
        collectedStamps,
      ];
}