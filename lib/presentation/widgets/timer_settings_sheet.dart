import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_state.dart';
import '../blocs/timer/timer_event.dart';

class TimerSettingsSheet extends StatefulWidget {
  final TimerBloc timerBloc;

  const TimerSettingsSheet({
    super.key,
    required this.timerBloc,
  });

  @override
  State<TimerSettingsSheet> createState() => _TimerSettingsSheetState();
}

class _TimerSettingsSheetState extends State<TimerSettingsSheet> {
  late int _focusMinutes;
  late int _breakMinutes;
  late String _selectedSound;
  late double _volume;

  @override
  void initState() {
    super.initState();
    final state = widget.timerBloc.state;
    _focusMinutes = state.focusMinutes;
    _breakMinutes = state.breakMinutes;
    _selectedSound = state.selectedSound;
    _volume = state.volume;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFocusLengthSection(),
                  const SizedBox(height: 32),
                  _buildBreakLengthSection(),
                  const SizedBox(height: 32),
                  _buildSoundSection(),
                  const SizedBox(height: 32),
                  _buildVolumeSection(),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Timer Settings',
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusLengthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Focus Session Length',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_focusMinutes minutes',
                style: AppTypography.titleMedium,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _focusMinutes > AppConstants.minTimerMinutes
                        ? () => setState(() => _focusMinutes--)
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: _focusMinutes < AppConstants.maxTimerMinutes
                        ? () => setState(() => _focusMinutes++)
                        : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _focusMinutes.toDouble(),
          min: AppConstants.minTimerMinutes.toDouble(),
          max: AppConstants.maxTimerMinutes.toDouble(),
          divisions: AppConstants.maxTimerMinutes - AppConstants.minTimerMinutes,
          onChanged: (value) {
            setState(() {
              _focusMinutes = value.round();
            });
          },
        ),
      ],
    );
  }

  Widget _buildBreakLengthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Break Length',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_breakMinutes minutes',
                style: AppTypography.titleMedium,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _breakMinutes > AppConstants.minBreakMinutes
                        ? () => setState(() => _breakMinutes--)
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  IconButton(
                    onPressed: _breakMinutes < AppConstants.maxBreakMinutes
                        ? () => setState(() => _breakMinutes++)
                        : null,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _breakMinutes.toDouble(),
          min: AppConstants.minBreakMinutes.toDouble(),
          max: AppConstants.maxBreakMinutes.toDouble(),
          divisions: AppConstants.maxBreakMinutes - AppConstants.minBreakMinutes,
          onChanged: (value) {
            setState(() {
              _breakMinutes = value.round();
            });
          },
        ),
      ],
    );
  }

  Widget _buildSoundSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ambient Sound',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...AppConstants.ambientSounds.map((sound) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: RadioListTile<String>(
              title: Text(sound),
              value: sound,
              groupValue: _selectedSound,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedSound = value;
                  });
                }
              },
              activeColor: AppColors.primary,
              tileColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildVolumeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Volume',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.volume_down),
              Expanded(
                child: Slider(
                  value: _volume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() {
                      _volume = value;
                    });
                  },
                ),
              ),
              const Icon(Icons.volume_up),
              const SizedBox(width: 16),
              Text(
                '${(_volume * 100).round()}%',
                style: AppTypography.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: _saveSettings,
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    widget.timerBloc.add(
      TimerSettingsUpdated(
        focusMinutes: _focusMinutes,
        breakMinutes: _breakMinutes,
        selectedSound: _selectedSound,
        volume: _volume,
      ),
    );
    Navigator.of(context).pop();
  }
}