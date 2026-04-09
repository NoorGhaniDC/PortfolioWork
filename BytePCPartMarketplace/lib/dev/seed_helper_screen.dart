import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_seed.dart';

/// Development screen to easily seed database with sample data.
/// Remove this from production builds.
class SeedHelperScreen extends StatefulWidget {
  const SeedHelperScreen({super.key});

  @override
  State<SeedHelperScreen> createState() => _SeedHelperScreenState();
}

class _SeedHelperScreenState extends State<SeedHelperScreen> {
  String _message = '';
  bool _isLoading = false;

  Future<void> _seedPartsCatalog() async {
    setState(() {
      _isLoading = true;
      _message = 'Seeding parts catalog...';
    });
    try {
      await seedPartsCatalog();
      setState(() => _message = '✅ Parts catalog seeded successfully!');
    } catch (e) {
      setState(() => _message = '❌ Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _seedListings() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _message = '❌ Please log in first to seed listings.');
      return;
    }
    setState(() {
      _isLoading = true;
      _message = 'Seeding sample listings...';
    });
    try {
      await seedListings(user.uid);
      setState(() => _message = '✅ Sample listings seeded successfully!');
    } catch (e) {
      setState(() => _message = '❌ Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _backfillListings() async {
    setState(() {
      _isLoading = true;
      _message = 'Backfilling existing listings...';
    });
    try {
      await backfillListings();
      setState(() =>
          _message = '✅ Listings backfilled! isActive and imageUrls added.');
    } catch (e) {
      setState(() => _message = '❌ Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Seed Helper'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '🛠️ Development Tools',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Use these buttons to populate your database with sample data',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),

              // User info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current User:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user != null
                          ? '${user.email ?? 'No email'}\nUID: ${user.uid}'
                          : '❌ Not logged in',
                      style: TextStyle(
                        fontSize: 12,
                        color: user != null ? Colors.black87 : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Seed Parts Catalog
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _seedPartsCatalog,
                icon: const Icon(Icons.inventory_2),
                label: const Text('1. Seed Parts Catalog'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Run this FIRST if parts catalog is empty',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Seed Sample Listings
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _seedListings,
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('2. Seed Sample Listings'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Run this AFTER seeding parts catalog (requires login)',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Backfill Listings
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _backfillListings,
                icon: const Icon(Icons.build_outlined),
                label: const Text('3. Backfill Existing Listings'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Run ONCE to add isActive and imageUrls to existing listings',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Status message
              if (_message.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _message.contains('✅')
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _message.contains('✅')
                          ? Colors.green.shade200
                          : Colors.red.shade200,
                    ),
                  ),
                  child: Text(
                    _message,
                    style: TextStyle(
                      color: _message.contains('✅')
                          ? Colors.green.shade900
                          : Colors.red.shade900,
                    ),
                  ),
                ),

              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
