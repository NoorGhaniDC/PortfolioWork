import 'package:bytepcmarketplace/widgets/common/app_footer.dart';
import 'package:flutter/material.dart';
import '../../widgets/common/app_navbar.dart';
import '../../widgets/about/about_hero.dart';
import '../../widgets/about/mission_section.dart';
import '../../widgets/about/how_it_works_section.dart';
import '../../widgets/about/cta_section.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      appBar: const AppNavbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AboutHero(isWide: isWide),
            MissionSection(isWide: isWide),
            HowItWorksSection(isWide: isWide),
            const CTASection(),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
