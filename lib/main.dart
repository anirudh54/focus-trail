import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'presentation/screens/splash_screen.dart';
import 'data/models/checkpoint.dart';
import 'data/models/trail.dart';
import 'data/models/user_progress.dart';
import 'data/models/session_record.dart';
import 'data/models/task_item.dart';
import 'data/models/achievement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (only for mobile platforms)
  try {
    await Firebase.initializeApp();
    print('✅ Firebase initialized successfully');
  } catch (e) {
    print('⚠️ Firebase initialization failed: $e');
    // Continue without Firebase for web development
  }
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(CheckpointAdapter());
  Hive.registerAdapter(TrailAdapter());
  Hive.registerAdapter(UserProgressAdapter());
  Hive.registerAdapter(SessionRecordAdapter());
  Hive.registerAdapter(TaskItemAdapter());
  Hive.registerAdapter(AchievementAdapter());
  Hive.registerAdapter(AchievementCategoryAdapter());
  
  // Open boxes
  await Hive.openBox<UserProgress>(AppConstants.userProgressBox);
  await Hive.openBox<SessionRecord>(AppConstants.sessionRecordsBox);
  await Hive.openBox<TaskItem>(AppConstants.tasksBox);
  await Hive.openBox<Achievement>(AppConstants.achievementsBox);
  
  runApp(const FocusTrailApp());
}

class FocusTrailApp extends StatelessWidget {
  const FocusTrailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
