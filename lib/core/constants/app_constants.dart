class AppConstants {
  // App Info
  static const String appName = 'Focus Trail';
  static const String appTagline = 'Transform Your Focus Into Adventure';
  
  // Timer Settings
  static const int defaultFocusMinutes = 25;
  static const int defaultBreakMinutes = 5;
  static const int minTimerMinutes = 15;
  static const int maxTimerMinutes = 60;
  static const int minBreakMinutes = 3;
  static const int maxBreakMinutes = 15;
  
  // Distance Calculation
  static const double milesPerSession = 1.0; // 1 mile per 25-minute session
  static const double kmPerMile = 1.60934;
  
  // Task Management
  static const int maxActiveTasks = 5;
  
  // Animation Durations
  static const Duration splashAnimationDuration = Duration(milliseconds: 1500);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Duration checkpointAnimationDuration = Duration(milliseconds: 2000);
  
  // Storage Keys
  static const String isFirstLaunchKey = 'isFirstLaunch';
  static const String currentTrailIdKey = 'currentTrailId';
  static const String userNameKey = 'userName';
  static const String notificationsEnabledKey = 'notificationsEnabled';
  static const String selectedSoundKey = 'selectedSound';
  static const String volumeKey = 'volume';
  static const String themeKey = 'theme';
  
  // Hive Box Names
  static const String userProgressBox = 'userProgress';
  static const String sessionRecordsBox = 'sessionRecords';
  static const String tasksBox = 'tasks';
  static const String achievementsBox = 'achievements';
  
  // Sound Files
  static const String forestSound = 'sounds/forest.mp3';
  static const String rainSound = 'sounds/rain.mp3';
  static const String whiteNoiseSound = 'sounds/white_noise.mp3';
  
  // Default Sounds
  static const List<String> ambientSounds = [
    'Forest',
    'Rain',
    'White Noise',
  ];
  
  // Achievement IDs
  static const String firstMileAchievement = 'first_mile';
  static const String weekWarriorAchievement = 'week_warrior';
  static const String tenSessionsAchievement = 'ten_sessions';
  static const String twentyFiveSessionsAchievement = 'twenty_five_sessions';
  static const String earlyBirdAchievement = 'early_bird';
  static const String weekendFocusAchievement = 'weekend_focus';
  
  // Trail Categories
  static const String natureCategory = 'Nature';
  static const String urbanCategory = 'Urban';
  static const String historicalCategory = 'Historical';
  static const String fantasyCategory = 'Fantasy';
  
  // Notification Settings
  static const String sessionCompleteNotificationId = 'sessionComplete';
  static const String breakReminderNotificationId = 'breakReminder';
}