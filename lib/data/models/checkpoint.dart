import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'checkpoint.g.dart';

@HiveType(typeId: 0)
class Checkpoint extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final double distanceFromStart;
  
  @HiveField(4)
  final String imageUrl;
  
  @HiveField(5)
  final String educationalFact;
  
  @HiveField(6)
  final bool isUnlocked;

  const Checkpoint({
    required this.id,
    required this.name,
    required this.description,
    required this.distanceFromStart,
    required this.imageUrl,
    required this.educationalFact,
    this.isUnlocked = false,
  });

  Checkpoint copyWith({
    String? id,
    String? name,
    String? description,
    double? distanceFromStart,
    String? imageUrl,
    String? educationalFact,
    bool? isUnlocked,
  }) {
    return Checkpoint(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      distanceFromStart: distanceFromStart ?? this.distanceFromStart,
      imageUrl: imageUrl ?? this.imageUrl,
      educationalFact: educationalFact ?? this.educationalFact,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        distanceFromStart,
        imageUrl,
        educationalFact,
        isUnlocked,
      ];
}