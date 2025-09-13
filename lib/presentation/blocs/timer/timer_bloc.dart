import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/session_record.dart';
import '../../../data/models/user_progress.dart';
import '../../../data/datasources/trail_data.dart';
import '../../../core/services/audio_service.dart';
import 'package:hive/hive.dart';
import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _tickerInterval = 1;
  Timer? _timer;
  final AudioService _audioService = AudioService();

  TimerBloc() : super(TimerState.initial()) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerPaused>(_onTimerPaused);
    on<TimerResumed>(_onTimerResumed);
    on<TimerReset>(_onTimerReset);
    on<TimerTicked>(_onTimerTicked);
    on<TimerCompleted>(_onTimerCompleted);
    on<TimerSettingsUpdated>(_onTimerSettingsUpdated);
    on<BreakStarted>(_onBreakStarted);
    on<CheckpointReached>(_onCheckpointReached);
    on<CheckpointModalDismissed>(_onCheckpointModalDismissed);
    
    _loadSettings();
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(state.copyWith(
      status: TimerStatus.running,
      duration: event.duration,
      remainingSeconds: event.duration,
    ));
    
    // Start ambient sound if enabled
    if (state.selectedSound.isNotEmpty && state.volume > 0) {
      _audioService.playAmbientSound(state.selectedSound);
    }
    
    _startTicker();
  }

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _audioService.pauseAmbientSound();
    emit(state.copyWith(status: TimerStatus.paused));
  }

  void _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) {
    emit(state.copyWith(status: TimerStatus.running));
    _audioService.resumeAmbientSound();
    _startTicker();
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _audioService.stopAmbientSound();
    emit(state.copyWith(
      status: TimerStatus.ready,
      remainingSeconds: state.isBreakTime 
          ? state.breakMinutes * 60 
          : state.focusMinutes * 60,
      duration: state.isBreakTime 
          ? state.breakMinutes * 60 
          : state.focusMinutes * 60,
    ));
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    if (event.duration > 0) {
      emit(state.copyWith(remainingSeconds: event.duration));
    } else {
      add(TimerCompleted());
    }
  }

  void _onTimerCompleted(TimerCompleted event, Emitter<TimerState> emit) async {
    _timer?.cancel();
    
    if (state.isBreakTime) {
      // Break completed, return to ready state
      emit(state.copyWith(
        status: TimerStatus.ready,
        isBreakTime: false,
        duration: state.focusMinutes * 60,
        remainingSeconds: state.focusMinutes * 60,
      ));
    } else {
      // Focus session completed
      _audioService.stopAmbientSound();
      _audioService.playNotificationSound();
      
      emit(state.copyWith(
        status: TimerStatus.completed,
        completedSessions: state.completedSessions + 1,
      ));
      
      // Save session record
      await _saveSessionRecord();
      
      // Update trail progress and check for checkpoints
      final reachedCheckpoint = await _updateTrailProgress();
      
      // If checkpoint reached, emit event for UI to show modal
      if (reachedCheckpoint != null) {
        add(CheckpointReached(reachedCheckpoint));
      }
      
      // Start break after a delay
      await Future.delayed(const Duration(seconds: 2));
      add(BreakStarted(state.breakMinutes * 60));
    }
  }

  void _onBreakStarted(BreakStarted event, Emitter<TimerState> emit) {
    emit(state.copyWith(
      status: TimerStatus.breakTime,
      isBreakTime: true,
      duration: event.duration,
      remainingSeconds: event.duration,
    ));
    _startTicker();
  }

  void _onTimerSettingsUpdated(TimerSettingsUpdated event, Emitter<TimerState> emit) {
    emit(state.copyWith(
      focusMinutes: event.focusMinutes,
      breakMinutes: event.breakMinutes,
      selectedSound: event.selectedSound,
      volume: event.volume,
      duration: state.isBreakTime ? event.breakMinutes * 60 : event.focusMinutes * 60,
      remainingSeconds: state.isBreakTime ? event.breakMinutes * 60 : event.focusMinutes * 60,
    ));
    
    // Update audio service volume
    _audioService.setVolume(event.volume);
    
    _saveSettings();
  }

  void _startTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: _tickerInterval),
      (timer) {
        add(TimerTicked(state.remainingSeconds - 1));
      },
    );
  }

  Future<void> _saveSessionRecord() async {
    final box = Hive.box<SessionRecord>(AppConstants.sessionRecordsBox);
    final prefs = await SharedPreferences.getInstance();
    final currentTrailId = prefs.getString(AppConstants.currentTrailIdKey) ?? 'golden_gate_park';
    
    final session = SessionRecord(
      date: DateTime.now(),
      focusMinutes: state.focusMinutes,
      distance: AppConstants.milesPerSession,
      tasksCompleted: 0, // Will be updated by task management
      trailId: currentTrailId,
      sessionType: 'focus',
      wasSuccessful: true,
    );
    
    await box.add(session);
  }

  Future<String?> _updateTrailProgress() async {
    final box = Hive.box<UserProgress>(AppConstants.userProgressBox);
    final prefs = await SharedPreferences.getInstance();
    final currentTrailId = prefs.getString(AppConstants.currentTrailIdKey) ?? 'golden_gate_park';
    
    UserProgress? progress = box.get(currentTrailId);
    final oldDistance = progress?.currentDistance ?? 0.0;
    final newDistance = oldDistance + AppConstants.milesPerSession;
    
    if (progress == null) {
      progress = UserProgress(
        trailId: currentTrailId,
        currentDistance: newDistance,
        totalSessions: 1,
        unlockedCheckpoints: [],
        lastSessionDate: DateTime.now(),
        collectedStamps: [],
      );
    } else {
      progress = progress.copyWith(
        currentDistance: newDistance,
        totalSessions: progress.totalSessions + 1,
        lastSessionDate: DateTime.now(),
      );
    }
    
    await box.put(currentTrailId, progress);
    
    // Check if any checkpoints were reached
    final trail = TrailData.sampleTrails.firstWhere(
      (t) => t.id == currentTrailId,
      orElse: () => TrailData.sampleTrails.first,
    );
    
    for (final checkpoint in trail.checkpoints) {
      if (oldDistance < checkpoint.distanceFromStart && 
          newDistance >= checkpoint.distanceFromStart &&
          !(progress?.unlockedCheckpoints.contains(checkpoint.id) ?? false)) {
        
        // Update progress with unlocked checkpoint
        if (progress != null) {
          progress = progress.copyWith(
            unlockedCheckpoints: [...progress.unlockedCheckpoints, checkpoint.id],
          );
          await box.put(currentTrailId, progress);
          
          return checkpoint.id;
        }
      }
    }
    
    return null;
  }

  void _onCheckpointReached(CheckpointReached event, Emitter<TimerState> emit) {
    // Update state with the reached checkpoint for UI to display modal
    emit(state.copyWith(recentCheckpointId: event.checkpointId));
  }

  void _onCheckpointModalDismissed(CheckpointModalDismissed event, Emitter<TimerState> emit) {
    // Clear the checkpoint from state
    emit(state.copyWith(recentCheckpointId: null));
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final focusMinutes = prefs.getInt('focusMinutes') ?? AppConstants.defaultFocusMinutes;
    final breakMinutes = prefs.getInt('breakMinutes') ?? AppConstants.defaultBreakMinutes;
    final selectedSound = prefs.getString(AppConstants.selectedSoundKey) ?? 'Forest';
    final volume = prefs.getDouble(AppConstants.volumeKey) ?? 0.7;
    
    add(TimerSettingsUpdated(
      focusMinutes: focusMinutes,
      breakMinutes: breakMinutes,
      selectedSound: selectedSound,
      volume: volume,
    ));
  }

  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('focusMinutes', state.focusMinutes);
    await prefs.setInt('breakMinutes', state.breakMinutes);
    await prefs.setString(AppConstants.selectedSoundKey, state.selectedSound);
    await prefs.setDouble(AppConstants.volumeKey, state.volume);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _audioService.dispose();
    return super.close();
  }
}