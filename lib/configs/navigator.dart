import 'package:ecommerceapp/auth/view.dart';
import 'package:ecommerceapp/category/view.dart';
import 'package:ecommerceapp/home/models.dart';
import 'package:ecommerceapp/home/view.dart';
import 'package:ecommerceapp/settings/view.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:go_router/go_router.dart';

class AppNavigator {
  static final router = GoRouter(
    routes: [
      GoRoute(
        name: 'home',
        path: HomeView.routeName,
        builder: (context, state) => const HomeView(),
        routes: [
          GoRoute(
            name: 'category',
            path: CategoryView.routeName.replaceFirst('/', ''),
            builder: (context, state) => CategoryView(
              categoryId: state.params['id']!,
              category: state.extra as Category?,
            ),
          ),
          GoRoute(
            path: SettingsView.routeName.replaceFirst('/', ''),
            builder: (context, state) => const SettingsView(),
          ),
        ],
      ),
      GoRoute(
        path: AuthView.routeName,
        builder: (context, state) => const AuthView(),
      ),
    ],
    debugLogDiagnostics: kDebugMode,
  );
}
