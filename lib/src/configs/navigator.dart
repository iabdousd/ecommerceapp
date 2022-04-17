import 'package:ecommerceapp/src/auth/views/register.dart';
import 'package:ecommerceapp/src/auth/views/verify_otp.dart';
import 'package:ecommerceapp/src/auth/views/view.dart';
import 'package:ecommerceapp/src/category/view.dart';
import 'package:ecommerceapp/src/home/models.dart';
import 'package:ecommerceapp/src/landing/view.dart';
import 'package:ecommerceapp/src/product/view.dart';
import 'package:ecommerceapp/src/settings/view.dart';
import 'package:ecommerceapp/src/shared/widgets/our_image.dart';
import 'package:ecommerceapp/src/splash/view.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:go_router/go_router.dart';

class AppNavigator {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: SplashView.routeName,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: 'home',
        path: LandingView.routeName,
        builder: (context, state) => const LandingView(),
        routes: [
          GoRoute(
            name: 'category',
            path: CategoryView.routeName,
            builder: (context, state) => CategoryView(
              categoryId: state.params['id']!,
              category: state.extra as Category?,
            ),
          ),
          GoRoute(
            name: 'product',
            path: ProductView.routeName,
            builder: (context, state) => ProductView(
              productId: state.params['id']!,
              product: state.extra as Product?,
            ),
          ),
          GoRoute(
            name: 'enlarged-image',
            path: EnlargedImageScreen.routeName,
            builder: (context, state) => EnlargedImageScreen(
              imageUrl: state.extra as String,
            ),
          ),
          GoRoute(
            name: 'settings',
            path: SettingsView.routeName,
            builder: (context, state) => const SettingsView(),
          ),
        ],
      ),
      GoRoute(
        path: AuthView.routeName,
        builder: (context, state) => const AuthView(),
        routes: [
          GoRoute(
            path: VerifyOtpView.routeName.replaceFirst('/', ''),
            builder: (context, state) => const VerifyOtpView(),
          ),
          GoRoute(
            path: RegisterView.routeName.replaceFirst('/', ''),
            builder: (context, state) => const RegisterView(),
          ),
        ],
      ),
    ],
    debugLogDiagnostics: kDebugMode,
  );
}
