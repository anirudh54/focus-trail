import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'checkpoint.dart';

part 'trail.g.dart';

@HiveType(typeId: 1)
class Trail extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String location;
  
  @HiveField(3)
  final double totalDistance;
  
  @HiveField(4)
  final String difficulty;
  
  @HiveField(5)
  final int estimatedSessions;
  
  @HiveField(6)
  final List<String> imageUrls;
  
  @HiveField(7)
  final List<Checkpoint> checkpoints;
  
  @HiveField(8)
  final String heroImageUrl;
  
  @HiveField(9)
  final String description;
  
  @HiveField(10)
  final bool isPremium;

  const Trail({
    required this.id,
    required this.name,
    required this.location,
    required this.totalDistance,
    required this.difficulty,
    required this.estimatedSessions,
    required this.imageUrls,
    required this.checkpoints,
    required this.heroImageUrl,
    required this.description,
    this.isPremium = false,
  });

  Trail copyWith({
    String? id,
    String? name,
    String? location,
    double? totalDistance,
    String? difficulty,
    int? estimatedSessions,
    List<String>? imageUrls,
    List<Checkpoint>? checkpoints,
    String? heroImageUrl,
    String? description,
    bool? isPremium,
  }) {
    return Trail(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      totalDistance: totalDistance ?? this.totalDistance,
      difficulty: difficulty ?? this.difficulty,
      estimatedSessions: estimatedSessions ?? this.estimatedSessions,
      imageUrls: imageUrls ?? this.imageUrls,
      checkpoints: checkpoints ?? this.checkpoints,
      heroImageUrl: heroImageUrl ?? this.heroImageUrl,
      description: description ?? this.description,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        totalDistance,
        difficulty,
        estimatedSessions,
        imageUrls,
        checkpoints,
        heroImageUrl,
        description,
        isPremium,
      ];
}