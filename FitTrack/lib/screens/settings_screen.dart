import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import '../providers/theme_provider.dart';
import '../services/user_service.dart';
import '../models/user_profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserService _userService = UserService();
  UserProfile? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await _userService.getUserProfile();
      setState(() {
        _userProfile = profile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateUserProfile(Map<String, dynamic> fields) async {
    try {
      await _userService.updateUserFields(fields);
      await _loadUserProfile();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  void _showWeightDialog() {
    if (_userProfile == null) return;

    final controller = TextEditingController(
        text: _userProfile!.weight.toStringAsFixed(1));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Weight'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (${_userProfile!.weightUnit})',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final value = double.tryParse(controller.text);
              if (value != null && value > 0) {
                await _updateUserProfile({'weight': value});
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showHeightDialog() {
    if (_userProfile == null) return;

    final controller = TextEditingController(
        text: _userProfile!.height.toStringAsFixed(1));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Height'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final value = double.tryParse(controller.text);
              if (value != null && value > 0) {
                await _updateUserProfile({'height': value});
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showGenderDialog() {
    if (_userProfile == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Gender'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Male'),
              value: 'Male',
              groupValue: _userProfile!.gender,
              onChanged: (value) async {
                await _updateUserProfile({'gender': value});
                if (mounted) Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Female'),
              value: 'Female',
              groupValue: _userProfile!.gender,
              onChanged: (value) async {
                await _updateUserProfile({'gender': value});
                if (mounted) Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Other'),
              value: 'Other',
              groupValue: _userProfile!.gender,
              onChanged: (value) async {
                await _updateUserProfile({'gender': value});
                if (mounted) Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging out: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          elevation: 0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_userProfile == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          elevation: 0,
        ),
        body: const Center(
          child: Text('Error loading profile'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0,
      ),
      body: ListView(
        children: [
          // Profile Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.monitor_weight),
            title: const Text('Weight'),
            subtitle: Text('${_userProfile!.weight.toStringAsFixed(1)} ${_userProfile!.weightUnit}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showWeightDialog,
          ),
          ListTile(
            leading: const Icon(Icons.height),
            title: const Text('Height'),
            subtitle: Text('${_userProfile!.height.toStringAsFixed(1)} cm'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showHeightDialog,
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Gender'),
            subtitle: Text(_userProfile!.gender),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showGenderDialog,
          ),
          const Divider(),

          // Measurement Preferences
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Measurements',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Weight Unit'),
            subtitle: Text(_userProfile!.weightUnit),
            trailing: DropdownButton<String>(
              value: _userProfile!.weightUnit,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'kg', child: Text('kg')),
                DropdownMenuItem(value: 'lbs', child: Text('lbs')),
              ],
              onChanged: (value) async {
                if (value != null) {
                  double newWeight = _userProfile!.weight;
                  if (_userProfile!.weightUnit == 'kg' && value == 'lbs') {
                    newWeight = newWeight * 2.20462;
                  } else if (_userProfile!.weightUnit == 'lbs' && value == 'kg') {
                    newWeight = newWeight / 2.20462;
                  }
                  await _updateUserProfile({
                    'weightUnit': value,
                    'weight': newWeight,
                  });
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.straighten),
            title: const Text('Distance Unit'),
            subtitle: Text(_userProfile!.distanceUnit),
            trailing: DropdownButton<String>(
              value: _userProfile!.distanceUnit,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'km', child: Text('km')),
                DropdownMenuItem(value: 'miles', child: Text('miles')),
              ],
              onChanged: (value) async {
                if (value != null) {
                  await _updateUserProfile({'distanceUnit': value});
                }
              },
            ),
          ),
          const Divider(),

          // Appearance
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Appearance',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          SwitchListTile(
            secondary: Icon(
              themeProvider.isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            title: const Text('Dark Mode'),
            subtitle: Text(
              themeProvider.isDarkMode ? 'Enabled' : 'Disabled',
            ),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
          const Divider(),

          // Account Actions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Account',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title:
            const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: _handleLogout,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}