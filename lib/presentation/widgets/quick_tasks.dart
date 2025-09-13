import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_constants.dart';

class QuickTasks extends StatefulWidget {
  const QuickTasks({super.key});

  @override
  State<QuickTasks> createState() => _QuickTasksState();
}

class _QuickTasksState extends State<QuickTasks> {
  final List<TaskItem> _tasks = [];
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Task list
        if (_tasks.isNotEmpty) ...[
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final task = _tasks[index];
              return _buildTaskItem(task, index);
            },
          ),
          const SizedBox(height: 16),
        ],
        
        // Add new task
        if (_tasks.length < AppConstants.maxActiveTasks)
          _buildAddTaskField(),
        
        // Task limit message
        if (_tasks.length >= AppConstants.maxActiveTasks)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Maximum ${AppConstants.maxActiveTasks} tasks reached. Complete some to add more.',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTaskItem(TaskItem task, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: task.isCompleted ? 0.1 : 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () => _toggleTask(index),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: task.isCompleted ? Colors.white : Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: task.isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 14,
                      color: AppColors.primary,
                    )
                  : null,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Task text
          Expanded(
            child: Text(
              task.title,
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.white,
                decoration: task.isCompleted 
                    ? TextDecoration.lineThrough 
                    : TextDecoration.none,
                decorationColor: Colors.white,
              ),
            ),
          ),
          
          // Delete button
          GestureDetector(
            onTap: () => _deleteTask(index),
            child: Icon(
              Icons.close,
              size: 18,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Add a quick task...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onSubmitted: _addTask,
            ),
          ),
          GestureDetector(
            onTap: () => _addTask(_textController.text),
            child: Icon(
              Icons.add,
              color: Colors.white.withValues(alpha: 0.8),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  void _addTask(String title) {
    if (title.trim().isNotEmpty && _tasks.length < AppConstants.maxActiveTasks) {
      setState(() {
        _tasks.add(TaskItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title.trim(),
          isCompleted: false,
        ));
        _textController.clear();
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      final task = _tasks[index];
      _tasks[index] = TaskItem(
        id: task.id,
        title: task.title,
        isCompleted: !task.isCompleted,
      );
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }
}

class TaskItem {
  final String id;
  final String title;
  final bool isCompleted;

  TaskItem({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
}