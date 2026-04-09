import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class BrandCarousel extends StatefulWidget {
  final bool isWide;
  const BrandCarousel({super.key, required this.isWide});

  @override
  State<BrandCarousel> createState() => _BrandCarouselState();
}

class _BrandCarouselState extends State<BrandCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  static const _components = [
    _ComponentItem(
      label: 'CPU',
      subtitle: 'Processors',
      icon: Icons.memory,
      gradient: [Color(0xFF0071C5), Color(0xFF00AEEF)],
      category: 'CPU',
    ),
    _ComponentItem(
      label: 'GPU',
      subtitle: 'Graphics cards',
      icon: Icons.videogame_asset,
      gradient: [Color(0xFF76B900), Color(0xFF4CAF50)],
      category: 'GPU',
    ),
    _ComponentItem(
      label: 'RAM',
      subtitle: 'Memory',
      icon: Icons.sd_card,
      gradient: [Color(0xFFFF6B35), Color(0xFFED1C24)],
      category: 'RAM',
    ),
    _ComponentItem(
      label: 'Motherboard',
      subtitle: 'Main boards',
      icon: Icons.developer_board,
      gradient: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
      category: 'Motherboard',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: widget.isWide ? 0.28 : 0.82,
      initialPage: _currentPage,
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      final next = (_currentPage + 1) % _components.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Shop by Component',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _components.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, index) {
                final component = _components[index];
                final isActive = index == _currentPage;
                return _ComponentCard(
                  component: component,
                  isActive: isActive,
                  onTap: () => context.go(
                    '${AppRoutes.marketplace}?category=${component.category}',
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _components.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == _currentPage ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: i == _currentPage
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComponentItem {
  final String label;
  final String subtitle;
  final IconData icon;
  final List<Color> gradient;
  final String category;

  const _ComponentItem({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.category,
  });
}

class _ComponentCard extends StatelessWidget {
  final _ComponentItem component;
  final bool isActive;
  final VoidCallback onTap;

  const _ComponentCard({
    required this.component,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isActive ? 1.0 : 0.92,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: component.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: component.gradient.first.withValues(alpha: 0.45),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(component.icon, size: 40, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  component.label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  component.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
