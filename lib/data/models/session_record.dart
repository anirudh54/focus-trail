import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'session_record.g.dart';

@HiveType(typeId: 3)
class SessionRecord extends Equatable {
  @HiveField(0)
  final DateTime date;
  
  @HiveField(1)
  final int focusMinutes;
  
  @HiveField(2)
  final double distance;
  
  @HiveField(3)
  final int tasksCompleted;
  
  @HiveField(4)
  final String trailId;
  
  @HiveField(5)
  final String sessionType;
  
  @HiveField(6)
  final bool wasSuccessful;

  const SessionRecord({
    required this.date,
    required this.focusMinutes,
    required this.distance,
    required this.tasksCompleted,
    required this.trailId,
    this.sessionType = 'focus',
    this.wasSuccessful = true,
  });

  SessionRecord copyWith({
    DateTime? date,
    int? focusMinutes,
    double? distance,
    int? tasksCompleted,
    String? trailId,
    String? sessionType,
    bool? wasSuccessful,
  }) {
    return SessionRecord(
      date: date ?? this.date,
      focusMinutes: focusMinutes ?? this.focusMinutes,
      distance: distance ?? this.distance,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      trailId: trailId ?? this.trailId,
      sessionType: sessionType ?? this.sessionType,
      wasSuccessful: wasSuccessful ?? this.wasSuccessful,
    );
  }

  @override
  List<Object?> get props => [
        date,
        focusMinutes,
        distance,
        tasksCompleted,
        trailId,
        sessionType,
        wasSuccessful,
      ];
}