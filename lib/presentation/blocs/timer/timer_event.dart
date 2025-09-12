import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class TimerStarted extends TimerEvent {
  final int duration;

  const TimerStarted(this.duration);

  @override
  List<Object?> get props => [duration];
}

class TimerPaused extends TimerEvent {}

class TimerResumed extends TimerEvent {}

class TimerReset extends TimerEvent {}

class TimerTicked extends TimerEvent {
  final int duration;

  const TimerTicked(this.duration);

  @override
  List<Object?> get props => [duration];
}

class TimerCompleted extends TimerEvent {}

class TimerSettingsUpdated extends TimerEvent {
  final int focusMinutes;
  final int breakMinutes;
  final String selectedSound;
  final double volume;

  const TimerSettingsUpdated({
    required this.focusMinutes,
    required this.breakMinutes,
    required this.selectedSound,
    required this.volume,
  });

  @override
  List<Object?> get props => [focusMinutes, breakMinutes, selectedSound, volume];
}

class BreakStarted extends TimerEvent {
  final int duration;

  const BreakStarted(this.duration);

  @override
  List<Object?> get props => [duration];
}

class CheckpointReached extends TimerEvent {
  final String checkpointId;

  const CheckpointReached(this.checkpointId);

  @override
  List<Object?> get props => [checkpointId];
}

class CheckpointModalDismissed extends TimerEvent {}