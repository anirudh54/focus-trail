import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'task_item.g.dart';

@HiveType(typeId: 4)
class TaskItem extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final bool isCompleted;
  
  @HiveField(3)
  final DateTime createdAt;
  
  @HiveField(4)
  final DateTime? completedAt;

  const TaskItem({
    required this.id,
    required this.title,
    required this.createdAt,
    this.isCompleted = false,
    this.completedAt,
  });

  TaskItem copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        isCompleted,
        createdAt,
        completedAt,
      ];
}