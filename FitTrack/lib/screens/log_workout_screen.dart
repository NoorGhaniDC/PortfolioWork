import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';
import '../services/workout_service.dart';
import '../models/workout.dart';

class LogWorkoutScreen extends StatefulWidget {
  const LogWorkoutScreen({super.key});

  @override
  State<LogWorkoutScreen> createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  final TextEditingController exerciseController = TextEditingController();

  // Weight-based controllers
  final TextEditingController setsController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  // Distance-based controllers
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController durationMinutesController = TextEditingController();
  final TextEditingController durationSecondsController = TextEditingController();

  String _workoutType = 'weight'; // 'weight' or 'distance'
  String _weightUnit = 'kg';
  String _distanceUnit = 'km';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUnits();
  }

  Future<void> _loadUnits() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _weightUnit = prefs.getString('weightUnit') ?? 'kg';
      _distanceUnit = prefs.getString('distanceUnit') ?? 'km';
    });
  }

  Future<void> _saveWorkout() async {
    if (exerciseController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an exercise name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_workoutType == 'weight') {
      if (setsController.text.isEmpty ||
          repsController.text.isEmpty ||
          weightController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final sets = int.tryParse(setsController.text);
      final reps = int.tryParse(repsController.text);
      final weight = double.tryParse(weightController.text);

      if (sets == null || reps == null || weight == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter valid numbers'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await _saveWeightWorkout(sets, reps, weight);
    } else {
      // Distance-based workout
      if (distanceController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter distance'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final distance = double.tryParse(distanceController.text);
      if (distance == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid distance'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final minutes = int.tryParse(durationMinutesController.text.isEmpty
          ? '0'
          : durationMinutesController.text) ?? 0;
      final seconds = int.tryParse(durationSecondsController.text.isEmpty
          ? '0'
          : durationSecondsController.text) ?? 0;

      final totalSeconds = (minutes * 60) + seconds;

      await _saveDistanceWorkout(distance, totalSeconds);
    }
  }

  Future<void> _saveWeightWorkout(int sets, int reps, double weight) async {
    setState(() => _isLoading = true);

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception('User not authenticated');

      final workout = Workout(
        id: '',
        userId: userId,
        exercise: exerciseController.text.trim(),
        workoutType: 'weight',
        sets: sets,
        reps: reps,
        weight: weight,
        weightUnit: _weightUnit,
        date: DateTime.now(),
        notes: null,
      );

      final workoutService = WorkoutService();
      await workoutService.addWorkout(workout);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout logged successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving workout: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveDistanceWorkout(double distance, int durationSeconds) async {
    setState(() => _isLoading = true);

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception('User not authenticated');

      final workout = Workout(
        id: '',
        userId: userId,
        exercise: exerciseController.text.trim(),
        workoutType: 'distance',
        distance: distance,
        duration: durationSeconds,
        distanceUnit: _distanceUnit,
        date: DateTime.now(),
        notes: null,
      );

      final workoutService = WorkoutService();
      await workoutService.addWorkout(workout);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout logged successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving workout: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    exerciseController.dispose();
    setsController.dispose();
    repsController.dispose();
    weightController.dispose();
    distanceController.dispose();
    durationMinutesController.dispose();
    durationSecondsController.dispose();
    super.dispose();
  }

  Widget _buildWeightFields() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: "Sets",
            controller: setsController,
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextField(
            label: "Reps",
            controller: repsController,
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextField(
            label: "Weight ($_weightUnit)",
            controller: weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceFields() {
    return Column(
      children: [
        CustomTextField(
          label: "Distance ($_distanceUnit)",
          controller: distanceController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: "Minutes",
                controller: durationMinutesController,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextField(
                label: "Seconds",
                controller: durationSecondsController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Log Exercise"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workout Type Selection
            const Text(
              'Workout Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fitness_center, size: 18),
                        SizedBox(width: 8),
                        Text('Weight'),
                      ],
                    ),
                    selected: _workoutType == 'weight',
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _workoutType = 'weight');
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_run, size: 18),
                        SizedBox(width: 8),
                        Text('Distance'),
                      ],
                    ),
                    selected: _workoutType == 'distance',
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _workoutType = 'distance');
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Exercise Name
            CustomTextField(
              label: _workoutType == 'weight'
                  ? "Exercise (e.g. Bench Press)"
                  : "Exercise (e.g. Running, Cycling)",
              controller: exerciseController,
            ),
            const SizedBox(height: 10),

            // Conditional Fields based on workout type
            if (_workoutType == 'weight')
              _buildWeightFields()
            else
              _buildDistanceFields(),

            const Spacer(),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              text: "Save Entry",
              onPressed: _saveWorkout,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}