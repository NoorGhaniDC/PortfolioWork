import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/workout_service.dart';
import '../models/workout.dart';
import '../utils/app_colors.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  Future<Map<String, dynamic>> _calculateAnalytics(
      List<Workout> workouts, String distanceUnit) async {
    if (workouts.isEmpty) {
      return {
        'totalWorkouts': 0,
        'totalDistance': 0.0,
        'totalWeight': 0.0,
        'heaviestWeight': 0.0,
        'heaviestWeightExercise': 'N/A',
        'longestDistance': 0.0,
        'longestDistanceExercise': 'N/A',
        'busiestDay': 'N/A',
        'busiestDayCount': 0,
        'weightWorkouts': 0,
        'distanceWorkouts': 0,
        'currentWeekWorkouts': 0,
        'lastWorkoutDate': 'N/A',
      };
    }

    // Basic counts
    int totalWorkouts = workouts.length;
    int weightWorkouts = workouts.where((w) => w.workoutType == 'weight').length;
    int distanceWorkouts = workouts.where((w) => w.workoutType == 'distance').length;

    // Total distance calculation with unit conversion
    double totalDistance = 0.0;
    for (var workout in workouts) {
      if (workout.workoutType == 'distance' && workout.distance != null) {
        double distance = workout.distance!;
        // Convert to user's preferred unit
        if (workout.distanceUnit == 'km' && distanceUnit == 'miles') {
          distance = distance * 0.621371; // km to miles
        } else if (workout.distanceUnit == 'miles' && distanceUnit == 'km') {
          distance = distance * 1.60934; // miles to km
        }
        totalDistance += distance;
      }
    }

    // Total weight lifted
    double totalWeight = 0.0;
    for (var workout in workouts) {
      if (workout.workoutType == 'weight' && workout.weight != null) {
        totalWeight += (workout.weight! * (workout.sets ?? 0) * (workout.reps ?? 0));
      }
    }

    // Heaviest single weight workout
    double heaviestWeight = 0.0;
    String heaviestWeightExercise = 'N/A';
    for (var workout in workouts) {
      if (workout.workoutType == 'weight' && workout.weight != null) {
        if (workout.weight! > heaviestWeight) {
          heaviestWeight = workout.weight!;
          heaviestWeightExercise = '${workout.exercise} (${workout.weight}${workout.weightUnit})';
        }
      }
    }

    // Longest distance workout
    double longestDistance = 0.0;
    String longestDistanceExercise = 'N/A';
    for (var workout in workouts) {
      if (workout.workoutType == 'distance' && workout.distance != null) {
        double distance = workout.distance!;
        // Convert for comparison
        if (workout.distanceUnit == 'km' && distanceUnit == 'miles') {
          distance = distance * 0.621371;
        } else if (workout.distanceUnit == 'miles' && distanceUnit == 'km') {
          distance = distance * 1.60934;
        }

        if (distance > longestDistance) {
          longestDistance = distance;
          longestDistanceExercise = '${workout.exercise} (${distance.toStringAsFixed(2)} $distanceUnit)';
        }
      }
    }

    // Find busiest day (most workouts on a single date)
    Map<String, int> workoutsByDay = {};
    for (var workout in workouts) {
      String dayKey = DateFormat('yyyy-MM-dd').format(workout.date);
      workoutsByDay[dayKey] = (workoutsByDay[dayKey] ?? 0) + 1;
    }

    String busiestDay = 'N/A';
    int busiestDayCount = 0;
    workoutsByDay.forEach((day, count) {
      if (count > busiestDayCount) {
        busiestDayCount = count;
        busiestDay = DateFormat('MMM dd, yyyy').format(DateTime.parse(day));
      }
    });

    // Current week workouts
    DateTime now = DateTime.now();
    DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
    int currentWeekWorkouts = workouts.where((w) {
      return w.date.isAfter(weekStart) && w.date.isBefore(now.add(const Duration(days: 1)));
    }).length;

    // Last workout date
    workouts.sort((a, b) => b.date.compareTo(a.date));
    String lastWorkoutDate = workouts.isNotEmpty
        ? DateFormat('MMM dd, yyyy').format(workouts.first.date)
        : 'N/A';

    return {
      'totalWorkouts': totalWorkouts,
      'totalDistance': totalDistance,
      'totalWeight': totalWeight,
      'heaviestWeight': heaviestWeight,
      'heaviestWeightExercise': heaviestWeightExercise,
      'longestDistance': longestDistance,
      'longestDistanceExercise': longestDistanceExercise,
      'busiestDay': busiestDay,
      'busiestDayCount': busiestDayCount,
      'weightWorkouts': weightWorkouts,
      'distanceWorkouts': distanceWorkouts,
      'currentWeekWorkouts': currentWeekWorkouts,
      'lastWorkoutDate': lastWorkoutDate,
    };
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
          "Analytics",
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
      body: FutureBuilder<String>(
        future: SharedPreferences.getInstance()
            .then((prefs) => prefs.getString('distanceUnit') ?? 'km'),
        builder: (context, distanceUnitSnapshot) {
          if (!distanceUnitSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final distanceUnit = distanceUnitSnapshot.data!;

          return StreamBuilder<List<Workout>>(
            stream: WorkoutService().getUserWorkouts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading analytics',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              }

              final workouts = snapshot.data ?? [];

              return FutureBuilder<Map<String, dynamic>>(
                future: _calculateAnalytics(workouts, distanceUnit),
                builder: (context, analyticsSnapshot) {
                  if (!analyticsSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final analytics = analyticsSnapshot.data!;

                  if (workouts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.analytics_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No workout data yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start logging workouts to see your analytics',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Overview Section
                        Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                context,
                                'Total Workouts',
                                '${analytics['totalWorkouts']}',
                                Icons.fitness_center,
                                AppColors.primary,
                                cardColor,
                                isDark,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                context,
                                'This Week',
                                '${analytics['currentWeekWorkouts']}',
                                Icons.calendar_today,
                                Colors.green,
                                cardColor,
                                isDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                context,
                                'Weight',
                                '${analytics['weightWorkouts']}',
                                Icons.fitness_center,
                                Colors.orange,
                                cardColor,
                                isDark,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                context,
                                'Distance',
                                '${analytics['distanceWorkouts']}',
                                Icons.directions_run,
                                Colors.blue,
                                cardColor,
                                isDark,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Distance Stats
                        if (analytics['distanceWorkouts'] > 0) ...[
                          Text(
                            'Distance Stats',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            context,
                            'Total Distance',
                            '${analytics['totalDistance'].toStringAsFixed(2)} $distanceUnit',
                            Icons.straighten,
                            Colors.blue,
                            cardColor,
                            isDark,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            context,
                            'Longest Distance',
                            analytics['longestDistanceExercise'],
                            Icons.emoji_events,
                            Colors.amber,
                            cardColor,
                            isDark,
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Weight Stats
                        if (analytics['weightWorkouts'] > 0) ...[
                          Text(
                            'Weight Stats',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            context,
                            'Total Weight Lifted',
                            '${analytics['totalWeight'].toStringAsFixed(0)} kg',
                            Icons.fitness_center,
                            Colors.deepOrange,
                            cardColor,
                            isDark,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            context,
                            'Heaviest Weight',
                            analytics['heaviestWeightExercise'],
                            Icons.emoji_events,
                            Colors.amber,
                            cardColor,
                            isDark,
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Activity Stats
                        Text(
                          'Activity',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          context,
                          'Busiest Day',
                          '${analytics['busiestDay']} (${analytics['busiestDayCount']} workouts)',
                          Icons.calendar_month,
                          Colors.purple,
                          cardColor,
                          isDark,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoCard(
                          context,
                          'Last Workout',
                          analytics['lastWorkoutDate'],
                          Icons.access_time,
                          Colors.teal,
                          cardColor,
                          isDark,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context,
      String label,
      String value,
      IconData icon,
      Color color,
      Color cardColor,
      bool isDark,
      ) {
    return Container(
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
        border: isDark ? Border.all(color: Colors.grey[800]!, width: 1) : null,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context,
      String label,
      String value,
      IconData icon,
      Color color,
      Color cardColor,
      bool isDark,
      ) {
    return Container(
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
        border: isDark ? Border.all(color: Colors.grey[800]!, width: 1) : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}