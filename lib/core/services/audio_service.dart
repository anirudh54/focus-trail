import 'package:audioplayers/audioplayers.dart';
import '../constants/app_constants.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String? _currentSound;
  double _volume = 0.7;

  bool get isPlaying => _isPlaying;
  String? get currentSound => _currentSound;
  double get volume => _volume;

  Future<void> playAmbientSound(String soundName) async {
    try {
      String soundPath;
      
      switch (soundName) {
        case 'Forest':
          soundPath = AppConstants.forestSound;
          break;
        case 'Rain':
          soundPath = AppConstants.rainSound;
          break;
        case 'White Noise':
          soundPath = AppConstants.whiteNoiseSound;
          break;
        default:
          soundPath = AppConstants.forestSound;
      }

      // For web, we'll use placeholder URLs or generate tones
      // In a real app, you would have actual audio files
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(_volume);
      
      // For demo purposes, we'll simulate playing the sound
      // In web environment, actual audio files would be needed
      
      _isPlaying = true;
      _currentSound = soundName;
      
      // Note: Actual audio playback would require real audio files
      // For the MVP demo, we'll track the state without actual audio
      
    } catch (e) {
      print('Error playing ambient sound: $e');
    }
  }

  Future<void> stopAmbientSound() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentSound = null;
    } catch (e) {
      print('Error stopping ambient sound: $e');
    }
  }

  Future<void> pauseAmbientSound() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
    } catch (e) {
      print('Error pausing ambient sound: $e');
    }
  }

  Future<void> resumeAmbientSound() async {
    try {
      await _audioPlayer.resume();
      _isPlaying = true;
    } catch (e) {
      print('Error resuming ambient sound: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    try {
      _volume = volume.clamp(0.0, 1.0);
      await _audioPlayer.setVolume(_volume);
    } catch (e) {
      print('Error setting volume: $e');
    }
  }

  Future<void> playNotificationSound() async {
    try {
      // Play a simple notification sound
      // This would be a short beep or chime for session completion
      final notificationPlayer = AudioPlayer();
      await notificationPlayer.setVolume(_volume);
      
      // For demo purposes, we'll just track that a notification sound was played
      print('Notification sound played');
      
      await notificationPlayer.dispose();
    } catch (e) {
      print('Error playing notification sound: $e');
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

// Ambient sound presets for the app
class AmbientSounds {
  static const List<AmbientSoundPreset> presets = [
    AmbientSoundPreset(
      name: 'Forest',
      description: 'Peaceful forest sounds with birds chirping',
      icon: '🌲',
    ),
    AmbientSoundPreset(
      name: 'Rain',
      description: 'Gentle rain drops and thunder',
      icon: '🌧️',
    ),
    AmbientSoundPreset(
      name: 'White Noise',
      description: 'Consistent white noise for deep focus',
      icon: '🔊',
    ),
  ];
}

class AmbientSoundPreset {
  final String name;
  final String description;
  final String icon;

  const AmbientSoundPreset({
    required this.name,
    required this.description,
    required this.icon,
  });
}