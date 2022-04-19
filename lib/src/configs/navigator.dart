import 'package:ecommerceapp/src/auth/views/register.dart';
import 'package:ecommerceapp/src/auth/views/verify_otp.dart';
import 'package:ecommerceapp/src/auth/views/view.dart';
import 'package:ecommerceapp/src/category/view.dart';
import 'package:ecommerceapp/src/checkout/view.dart';
import 'package:ecommerceapp/src/home/models.dart';
import 'package:ecommerceapp/src/landing/view.dart';
import 'package:ecommerceapp/src/orders/views/details.dart';
import 'package:ecommerceapp/src/orders/views/list.dart';
import 'package:ecommerceapp/src/product/view.dart';
import 'package:ecommerceapp/src/settings/view.dart';
import 'package:ecommerceapp/src/shared/widgets/our_image.dart';
import 'package:ecommerceapp/src/splash/view.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  static BuildContext get context => router.navigator!.context;

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: SplashView.routeName,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        name: LandingView.routeName,
        path: LandingView.routeName,
        builder: (context, state) => const LandingView(),
        routes: [
          GoRoute(
            name: CategoryView.routeName,
            path: CategoryView.routeName,
            builder: (context, state) => CategoryView(
              categoryId: state.params['categoryId']!,
              category: state.extra as Category?,
            ),
          ),
          GoRoute(
            name: ProductView.routeName,
            path: ProductView.routeName,
            builder: (context, state) => ProductView(
              productId: state.params['productId']!,
              product: state.extra as Product?,
            ),
          ),
          GoRoute(
            name: CheckoutView.routeName,
            path: CheckoutView.routeName,
            builder: (context, state) => const CheckoutView(),
          ),
          GoRoute(
            name: OrdersView.routeName,
            path: OrdersView.routeName,
            builder: (context, state) => const OrdersView(),
          ),
          GoRoute(
            name: OrderView.routeName,
            path: OrderView.routeName,
            builder: (context, state) => const OrderView(),
          ),
          GoRoute(
            name: EnlargedImageScreen.routeName,
            path: EnlargedImageScreen.routeName,
            builder: (context, state) => EnlargedImageScreen(
              imageUrl: state.extra as String,
            ),
          ),
          GoRoute(
            name: SettingsView.routeName,
            path: SettingsView.routeName,
            builder: (context, state) => const SettingsView(),
          ),
        ],
      ),
      GoRoute(
        name: AuthView.routeName,
        path: AuthView.routeName,
        builder: (context, state) => const AuthView(),
        routes: [
          GoRoute(
            name: VerifyOtpView.routeName,
            path: VerifyOtpView.routeName,
            builder: (context, state) => const VerifyOtpView(),
          ),
          GoRoute(
            name: RegisterView.routeName,
            path: RegisterView.routeName,
            builder: (context, state) => const RegisterView(),
          ),
        ],
      ),
    ],
    debugLogDiagnostics: kDebugMode,
  );
}
