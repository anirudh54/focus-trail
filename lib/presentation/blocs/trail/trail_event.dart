import 'package:equatable/equatable.dart';

abstract class TrailEvent extends Equatable {
  const TrailEvent();

  @override
  List<Object?> get props => [];
}

class TrailSelected extends TrailEvent {
  final String trailId;

  const TrailSelected(this.trailId);

  @override
  List<Object?> get props => [trailId];
}

class TrailLoaded extends TrailEvent {}