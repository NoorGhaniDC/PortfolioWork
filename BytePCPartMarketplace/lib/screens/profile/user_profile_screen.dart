import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/listing_model.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../services/listing_service.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/common/app_footer.dart';
import '../../widgets/profile/user_profile_header.dart';
import '../../widgets/profile/user_profile_listings_section.dart';
import '../../widgets/profile/user_profile_login_prompt.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;

  const UserProfileScreen({required this.userId, super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<List<ListingModel>> _listingsFuture;
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _listingsFuture = ListingService().getListingsBySeller(widget.userId);
  }

  Future<void> _loadUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (doc.exists) {
        setState(() {
          _user = UserModel.fromMap(doc.data()!);
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoggedIn = authProvider.isLoggedIn;

    return Scaffold(
      appBar: const AppNavbar(),
      body: !isLoggedIn
          ? const UserProfileLoginPrompt()
          : _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Profile Header
                      UserProfileHeader(user: _user),
                      // Listings Section
                      UserProfileListingsSection(
                          listingsFuture: _listingsFuture),
                      const AppFooter(),
                    ],
                  ),
                ),
    );
  }
}
