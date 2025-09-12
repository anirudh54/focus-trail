import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/datasources/trail_data.dart';
import '../../../data/models/trail.dart';
import 'trail_event.dart';
import 'trail_state.dart';

class TrailBloc extends Bloc<TrailEvent, TrailState> {
  TrailBloc() : super(TrailState.initial()) {
    on<TrailLoaded>(_onTrailLoaded);
    on<TrailSelected>(_onTrailSelected);
    
    // Load the current trail on initialization
    add(TrailLoaded());
  }

  void _onTrailLoaded(TrailLoaded event, Emitter<TrailState> emit) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentTrailId = prefs.getString(AppConstants.currentTrailIdKey) ?? 'golden_gate_park';
      
      final availableTrails = TrailData.sampleTrails;
      final currentTrail = availableTrails.firstWhere(
        (trail) => trail.id == currentTrailId,
        orElse: () => availableTrails.first,
      );

      emit(state.copyWith(
        currentTrail: currentTrail,
        availableTrails: availableTrails,
        isLoading: false,
      ));
    } catch (e) {
      // Fallback to default trail
      final availableTrails = TrailData.sampleTrails;
      emit(state.copyWith(
        currentTrail: availableTrails.first,
        availableTrails: availableTrails,
        isLoading: false,
      ));
    }
  }

  void _onTrailSelected(TrailSelected event, Emitter<TrailState> emit) async {
    try {
      final selectedTrail = state.availableTrails.firstWhere(
        (trail) => trail.id == event.trailId,
      );

      // Save the selected trail to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.currentTrailIdKey, event.trailId);

      emit(state.copyWith(currentTrail: selectedTrail));
    } catch (e) {
      // Trail not found, ignore the selection
      print('Trail not found: ${event.trailId}');
    }
  }
}