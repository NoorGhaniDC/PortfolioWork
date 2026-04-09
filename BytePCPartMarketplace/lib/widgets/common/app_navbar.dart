import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/notification_provider.dart';

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final cartProvider = context.watch<CartProvider>();
    final isLoggedIn = authProvider.isLoggedIn;
    final isWide = MediaQuery.of(context).size.width > 768;
    final currentLocation = GoRouterState.of(context).uri.toString();

    return AppBar(
      backgroundColor: AppColors.navbarBg,
      title: GestureDetector(
        onTap: () => context.go(AppRoutes.home),
        child: const Text(
          AppStrings.appName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      actions: isWide
          ? [
              _NavItem(
                  label: AppStrings.home,
                  route: AppRoutes.home,
                  current: currentLocation),
              _NavItem(
                  label: AppStrings.marketplace,
                  route: AppRoutes.marketplace,
                  current: currentLocation),
              const SizedBox(width: 8),
              if (isLoggedIn) ...[
                _NavItem(
                    label: AppStrings.profile,
                    route: AppRoutes.profile,
                    current: currentLocation),
                _NavItem(
                    label: AppStrings.createListing,
                    route: AppRoutes.createListing,
                    current: currentLocation),
                const SizedBox(width: 8),
                const _NotificationsIcon(),
                _LogoutButton(),
              ] else ...[
                _NavItem(
                    label: AppStrings.login,
                    route: AppRoutes.login,
                    current: currentLocation),
                const SizedBox(width: 8),
                _RegisterButton(),
              ],
              const SizedBox(width: 8),
              _CartIcon(itemCount: cartProvider.itemCount),
              const SizedBox(width: 16),
            ]
          : [
              if (isLoggedIn) const _NotificationsIcon(),
              _CartIcon(itemCount: cartProvider.itemCount),
              const SizedBox(width: 4),
              _MobileMenuButton(
                  isLoggedIn: isLoggedIn, current: currentLocation),
            ],
    );
  }
}

// ─── Notifications Icon ───────────────────────────────────────────────────────
class _NotificationsIcon extends StatelessWidget {
  const _NotificationsIcon();

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () => context.go(AppRoutes.notifications),
              tooltip: 'Notifications',
            ),
            if (provider.unreadCount > 0)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  constraints:
                      const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    provider.unreadCount > 9 ? '9+' : '${provider.unreadCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ─── Cart Icon ────────────────────────────────────────────────────────────────
class _CartIcon extends StatelessWidget {
  final int itemCount;

  const _CartIcon({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          onPressed: () => context.go(AppRoutes.cart),
          tooltip: 'Cart',
        ),
        if (itemCount > 0)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                itemCount > 9 ? '9+' : '$itemCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Desktop Nav Item ─────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final String label;
  final String route;
  final String current;

  const _NavItem({
    required this.label,
    required this.route,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = current == route;
    return Tooltip(
      message: 'Go to $label',
      child: TextButton(
        onPressed: () => context.go(route),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            decoration:
                isActive ? TextDecoration.underline : TextDecoration.none,
            decorationColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ─── Register Button ──────────────────────────────────────────────────────────
class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Create a new account',
      child: ElevatedButton(
        onPressed: () => context.go(AppRoutes.register),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.navbarBg,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: const Text(AppStrings.register),
      ),
    );
  }
}

// ─── Logout Button ────────────────────────────────────────────────────────────
class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Sign out from your account',
      child: TextButton.icon(
        onPressed: () async {
          context.read<CartProvider>().clear();
          await context.read<AuthProvider>().logout();
          if (context.mounted) context.go(AppRoutes.home);
        },
        icon: const Icon(Icons.logout, color: Colors.white70, size: 18),
        label: const Text(
          AppStrings.logout,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}

// ─── Mobile Menu ──────────────────────────────────────────────────────────────
class _MobileMenuButton extends StatelessWidget {
  final bool isLoggedIn;
  final String current;

  const _MobileMenuButton({required this.isLoggedIn, required this.current});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Open navigation menu',
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.menu, color: Colors.white),
        onSelected: (route) {
          if (route == 'logout') {
            context.read<CartProvider>().clear();
            context.read<AuthProvider>().logout();
            context.go(AppRoutes.home);
          } else {
            context.go(route);
          }
        },
        itemBuilder: (context) => [
          _menuItem(AppStrings.home, AppRoutes.home),
          _menuItem(AppStrings.marketplace, AppRoutes.marketplace),
          _menuItem('Cart', AppRoutes.cart),
          const PopupMenuDivider(),
          if (isLoggedIn) ...[
            _menuItem(AppStrings.profile, AppRoutes.profile),
            _menuItem(AppStrings.createListing, AppRoutes.createListing),
            _menuItem('Notifications', AppRoutes.notifications),
            _menuItem(AppStrings.logout, 'logout'),
          ] else ...[
            _menuItem(AppStrings.login, AppRoutes.login),
            _menuItem(AppStrings.register, AppRoutes.register),
          ],
        ],
      ),
    );
  }

  PopupMenuItem<String> _menuItem(String label, String value) {
    return PopupMenuItem<String>(value: value, child: Text(label));
  }
}
