import 'package:equatable/equatable.dart';
import '../../../data/models/trail.dart';

class TrailState extends Equatable {
  final Trail? currentTrail;
  final List<Trail> availableTrails;
  final bool isLoading;

  const TrailState({
    this.currentTrail,
    this.availableTrails = const [],
    this.isLoading = false,
  });

  factory TrailState.initial() {
    return const TrailState(
      currentTrail: null,
      availableTrails: [],
      isLoading: true,
    );
  }

  TrailState copyWith({
    Trail? currentTrail,
    List<Trail>? availableTrails,
    bool? isLoading,
  }) {
    return TrailState(
      currentTrail: currentTrail ?? this.currentTrail,
      availableTrails: availableTrails ?? this.availableTrails,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [currentTrail, availableTrails, isLoading];
}