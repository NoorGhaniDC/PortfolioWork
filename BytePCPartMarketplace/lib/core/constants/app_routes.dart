import 'package:go_router/go_router.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/about/about_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/marketplace/marketplace_screen.dart';
import '../../screens/marketplace/listing_detail_screen.dart';
import '../../screens/listing/create_listing_screen.dart';
import '../../screens/listing/edit_listing_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/cart/checkout_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/profile/user_profile_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../dev/seed_helper_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String about = '/about';
  static const String login = '/login';
  static const String register = '/register';
  static const String marketplace = '/marketplace';
  static const String listingDetail = '/listing/:id';
  static const String userProfile = '/user/:userId';
  static const String createListing = '/create-listing';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String notifications = '/notifications';
  static const String seedHelper = '/dev/seed-helper';
  static const String editListing = '/listing/:listingId/edit';
  static const String cart = '/cart';
  static const String checkout = '/checkout';

  static final router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(path: home, builder: (ctx, state) => const HomeScreen()),
      GoRoute(path: about, builder: (ctx, state) => const AboutScreen()),
      GoRoute(path: login, builder: (ctx, state) => const LoginScreen()),
      GoRoute(path: register, builder: (ctx, state) => const RegisterScreen()),
      GoRoute(
        path: marketplace,
        builder: (ctx, state) => const MarketplaceScreen(),
      ),
      GoRoute(
        path: listingDetail,
        builder: (ctx, state) => ListingDetailScreen(
          listingId: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(
        path: userProfile,
        builder: (ctx, state) => UserProfileScreen(
          userId: state.pathParameters['userId'] ?? '',
        ),
      ),
      GoRoute(
        path: editListing,
        builder: (ctx, state) => EditListingScreen(
          listingId: state.pathParameters['listingId'] ?? '',
        ),
      ),
      GoRoute(
        path: createListing,
        builder: (ctx, state) => const CreateListingScreen(),
      ),
      GoRoute(path: cart, builder: (ctx, state) => const CartScreen()),
      GoRoute(path: checkout, builder: (ctx, state) => const CheckoutScreen()),
      GoRoute(
        path: profile,
        builder: (ctx, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: editProfile,
        builder: (ctx, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: notifications,
        builder: (ctx, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: seedHelper,
        builder: (ctx, state) => const SeedHelperScreen(),
      ),
    ],
  );
}
