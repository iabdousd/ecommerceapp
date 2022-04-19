import 'package:ecommerceapp/src/cart/controller.dart';
import 'package:ecommerceapp/src/cart/view.dart';
import 'package:ecommerceapp/src/home/view.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/profile/view.dart';
import 'package:ecommerceapp/src/shared/widgets/badge.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';

class LandingView extends StatefulWidget {
  static const routeName = '/landing';
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollable: false,
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeView(),
          SizedBox(),
          CartView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _tabController,
        builder: (context, _) {
          return SnakeNavigationBar.color(
            currentIndex: _tabController.index,
            onTap: _tabController.animateTo,
            snakeShape: SnakeShape.indicator,
            snakeViewColor: Theme.of(context).primaryColor,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            height: 68,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home_rounded),
                label: AppLocalization.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search_outlined),
                activeIcon: const Icon(Icons.search_rounded),
                label: AppLocalization.of(context).search,
              ),
              BottomNavigationBarItem(
                icon: Builder(
                  builder: (context) {
                    return AppBadge(
                      value: context.select<CartController, int>(
                        (controller) => controller.items.length,
                      ),
                      child: const Icon(Icons.shopping_cart_outlined),
                    );
                  },
                ),
                activeIcon: const Icon(Icons.shopping_cart_rounded),
                label: AppLocalization.of(context).cart,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle_outlined),
                activeIcon: const Icon(Icons.account_circle_rounded),
                label: AppLocalization.of(context).profile,
              ),
            ],
          );
        },
      ),
    );
  }
}
