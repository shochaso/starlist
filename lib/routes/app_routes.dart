import 'package:flutter/material.dart';
import '../models/star.dart';
import '../screens/home_screen.dart';
import '../screens/category_screen.dart';
import '../screens/star_detail_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/mypage_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String category = '/category';
  static const String starDetail = '/star_detail';
  static const String favorites = '/favorites';
  static const String mypage = '/mypage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            onThemeToggle: settings.arguments as VoidCallback?,
          ),
        );

      case category:
        final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => CategoryScreen(
            category: args['category'] as String,
          ),
        );

      case starDetail:
        final Star star = settings.arguments as Star;
        return MaterialPageRoute(
          builder: (context) => StarDetailScreen(
            star: star,
          ),
        );

      case favorites:
        return MaterialPageRoute(
          builder: (context) => FavoritesScreen(),
        );

      case mypage:
        return MaterialPageRoute(
          builder: (context) => MypageScreen(
            onThemeToggle: settings.arguments as VoidCallback?,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('ルートが見つかりません: ${settings.name}'),
            ),
          ),
        );
    }
  }
} 