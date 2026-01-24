import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/user_service.dart';
import '../utils/app_colors.dart';
import 'settings_screen.dart';

class AIRecommendationsScreen extends StatefulWidget {
  const AIRecommendationsScreen({super.key});

  @override
  State<AIRecommendationsScreen> createState() => _AIRecommendationsScreenState();
}

class _AIRecommendationsScreenState extends State<AIRecommendationsScreen> {
  final UserService _userService = UserService();
  UserProfile? _userProfile;
  bool _isLoading = true;
  List<WorkoutRecommendation> _recommendations = [];

  @override
  void initState() {
    super.initState();
    _loadProfileAndGenerateRecommendations();
  }

  Future<void> _loadProfileAndGenerateRecommendations() async {
    try {
      final profile = await _userService.getUserProfile();

      if (profile == null) {
        _navigateToSettings();
        return;
      }

      // Check if profile is complete
      if (profile.weight <= 0 || profile.height <= 0) {
        _navigateToSettings();
        return;
      }

      setState(() {
        _userProfile = profile;
        _recommendations = _generateRecommendations(profile);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToSettings() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please complete your profile to get personalized recommendations'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  List<WorkoutRecommendation> _generateRecommendations(UserProfile profile) {
    List<WorkoutRecommendation> recommendations = [];

    // Calculate BMI
    double heightInMeters = profile.height / 100;
    double bmi = profile.weight / (heightInMeters * heightInMeters);

    // Determine fitness level based on BMI
    String fitnessLevel = 'intermediate';
    if (bmi < 18.5) {
      fitnessLevel = 'beginner';
    } else if (bmi > 25) {
      fitnessLevel = 'beginner';
    }

    // Gender-specific recommendations
    if (profile.gender == 'Male') {
      recommendations.addAll([
        WorkoutRecommendation(
          name: 'Bench Press',
          type: 'weight',
          sets: fitnessLevel == 'beginner' ? 3 : 4,
          reps: fitnessLevel == 'beginner' ? 8 : 10,
          weight: _calculateRecommendedWeight(profile.weight, 0.5),
          weightUnit: profile.weightUnit,
          description: 'Great for building upper body strength and chest muscles',
          icon: Icons.fitness_center,
        ),
        WorkoutRecommendation(
          name: 'Squats',
          type: 'weight',
          sets: fitnessLevel == 'beginner' ? 3 : 4,
          reps: fitnessLevel == 'beginner' ? 10 : 12,
          weight: _calculateRecommendedWeight(profile.weight, 0.7),
          weightUnit: profile.weightUnit,
          description: 'Essential for leg strength and overall power',
          icon: Icons.fitness_center,
        ),
        WorkoutRecommendation(
          name: 'Deadlifts',
          type: 'weight',
          sets: 3,
          reps: fitnessLevel == 'beginner' ? 6 : 8,
          weight: _calculateRecommendedWeight(profile.weight, 0.8),
          weightUnit: profile.weightUnit,
          description: 'Full body compound exercise for strength',
          icon: Icons.fitness_center,
        ),
      ]);
    } else if (profile.gender == 'Female') {
      recommendations.addAll([
        WorkoutRecommendation(
          name: 'Squats',
          type: 'weight',
          sets: fitnessLevel == 'beginner' ? 3 : 4,
          reps: fitnessLevel == 'beginner' ? 10 : 12,
          weight: _calculateRecommendedWeight(profile.weight, 0.6),
          weightUnit: profile.weightUnit,
          description: 'Excellent for lower body toning and strength',
          icon: Icons.fitness_center,
        ),
        WorkoutRecommendation(
          name: 'Glute Bridges',
          type: 'weight',
          sets: 3,
          reps: 15,
          weight: _calculateRecommendedWeight(profile.weight, 0.4),
          weightUnit: profile.weightUnit,
          description: 'Target glutes and hamstrings effectively',
          icon: Icons.fitness_center,
        ),
        WorkoutRecommendation(
          name: 'Dumbbell Rows',
          type: 'weight',
          sets: 3,
          reps: 12,
          weight: _calculateRecommendedWeight(profile.weight, 0.3),
          weightUnit: profile.weightUnit,
          description: 'Build back strength and improve posture',
          icon: Icons.fitness_center,
        ),
      ]);
    } else {
      recommendations.addAll([
        WorkoutRecommendation(
          name: 'Squats',
          type: 'weight',
          sets: 3,
          reps: 10,
          weight: _calculateRecommendedWeight(profile.weight, 0.6),
          weightUnit: profile.weightUnit,
          description: 'Essential lower body exercise',
          icon: Icons.fitness_center,
        ),
        WorkoutRecommendation(
          name: 'Push-ups',
          type: 'weight',
          sets: 3,
          reps: 15,
          weight: 0,
          weightUnit: profile.weightUnit,
          description: 'Bodyweight upper body builder',
          icon: Icons.fitness_center,
        ),
      ]);
    }

    // Add cardio recommendations
    double recommendedDistance = bmi < 25 ? 5.0 : 3.0;
    recommendations.add(
      WorkoutRecommendation(
        name: 'Running',
        type: 'distance',
        distance: recommendedDistance,
        distanceUnit: profile.distanceUnit,
        duration: (recommendedDistance * 6 * 60).toInt(), // ~6 min per km
        description: 'Improve cardiovascular health and endurance',
        icon: Icons.directions_run,
      ),
    );

    recommendations.add(
      WorkoutRecommendation(
        name: 'Cycling',
        type: 'distance',
        distance: recommendedDistance * 3,
        distanceUnit: profile.distanceUnit,
        duration: (recommendedDistance * 3 * 4 * 60).toInt(), // ~4 min per km
        description: 'Low-impact cardio for building stamina',
        icon: Icons.directions_bike,
      ),
    );

    return recommendations;
  }

  double _calculateRecommendedWeight(double bodyWeight, double multiplier) {
    return (bodyWeight * multiplier).roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : AppColors.background;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "AI Workout Recommendations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _userProfile == null
          ? const Center(child: Text('Unable to load profile'))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDark
                    ? null
                    : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: isDark
                    ? Border.all(color: Colors.grey[800]!, width: 1)
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personalized for ${_userProfile!.name}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_userProfile!.gender} • ${_userProfile!.weight.toStringAsFixed(0)}${_userProfile!.weightUnit} • ${_userProfile!.height.toStringAsFixed(0)}cm',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recommendations Header
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: AppColors.accent),
                const SizedBox(width: 8),
                Text(
                  'Recommended Workouts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'AI-generated based on your profile',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),

            // Recommendations List
            ...List.generate(_recommendations.length, (index) {
              final rec = _recommendations[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isDark
                      ? null
                      : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: isDark
                      ? Border.all(color: Colors.grey[800]!, width: 1)
                      : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              rec.icon,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rec.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (rec.type == 'weight')
                                  Text(
                                    '${rec.sets} sets × ${rec.reps} reps @ ${rec.weight}${rec.weightUnit}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  )
                                else
                                  Text(
                                    '${rec.distance}${rec.distanceUnit} • ${(rec.duration! / 60).round()} min',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        rec.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.grey[400] : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class WorkoutRecommendation {
  final String name;
  final String type;
  final int? sets;
  final int? reps;
  final double? weight;
  final String? weightUnit;
  final double? distance;
  final String? distanceUnit;
  final int? duration;
  final String description;
  final IconData icon;

  WorkoutRecommendation({
    required this.name,
    required this.type,
    this.sets,
    this.reps,
    this.weight,
    this.weightUnit,
    this.distance,
    this.distanceUnit,
    this.duration,
    required this.description,
    required this.icon,
  });
}