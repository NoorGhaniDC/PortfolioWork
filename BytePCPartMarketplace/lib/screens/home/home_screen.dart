import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/common/app_footer.dart';
import '../../widgets/common/carousel.dart';
import '../../widgets/home/hero_section.dart';
import '../../widgets/home/features_section.dart';
import '../../widgets/home/home_cta_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    final isWide = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      appBar: const AppNavbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeroSection(isLoggedIn: isLoggedIn, isWide: isWide),
            BrandCarousel(isWide: isWide),
            FeaturesSection(isWide: isWide),
            HomeCtaSection(isLoggedIn: isLoggedIn),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
