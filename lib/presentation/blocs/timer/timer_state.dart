import 'package:equatable/equatable.dart';

enum TimerStatus { ready, running, paused, breakTime, completed }

class TimerState extends Equatable {
  final TimerStatus status;
  final int duration;
  final int remainingSeconds;
  final int focusMinutes;
  final int breakMinutes;
  final String selectedSound;
  final double volume;
  final int completedSessions;
  final bool isBreakTime;
  final String? recentCheckpointId;

  const TimerState({
    required this.status,
    required this.duration,
    required this.remainingSeconds,
    required this.focusMinutes,
    required this.breakMinutes,
    required this.selectedSound,
    required this.volume,
    this.completedSessions = 0,
    this.isBreakTime = false,
    this.recentCheckpointId,
  });

  factory TimerState.initial() {
    return const TimerState(
      status: TimerStatus.ready,
      duration: 25 * 60, // 25 minutes in seconds
      remainingSeconds: 25 * 60,
      focusMinutes: 25,
      breakMinutes: 5,
      selectedSound: 'Forest',
      volume: 0.7,
      completedSessions: 0,
      isBreakTime: false,
      recentCheckpointId: null,
    );
  }

  TimerState copyWith({
    TimerStatus? status,
    int? duration,
    int? remainingSeconds,
    int? focusMinutes,
    int? breakMinutes,
    String? selectedSound,
    double? volume,
    int? completedSessions,
    bool? isBreakTime,
    String? recentCheckpointId,
  }) {
    return TimerState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      focusMinutes: focusMinutes ?? this.focusMinutes,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      selectedSound: selectedSound ?? this.selectedSound,
      volume: volume ?? this.volume,
      completedSessions: completedSessions ?? this.completedSessions,
      isBreakTime: isBreakTime ?? this.isBreakTime,
      recentCheckpointId: recentCheckpointId ?? this.recentCheckpointId,
    );
  }

  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progress {
    if (duration == 0) return 0.0;
    return (duration - remainingSeconds) / duration;
  }

  @override
  List<Object?> get props => [
        status,
        duration,
        remainingSeconds,
        focusMinutes,
        breakMinutes,
        selectedSound,
        volume,
        completedSessions,
        isBreakTime,
        recentCheckpointId,
      ];
}