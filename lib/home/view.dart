import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/category/view.dart';
import 'package:ecommerceapp/configs/theme.dart';
import 'package:ecommerceapp/home/controller.dart';
import 'package:ecommerceapp/home/models.dart';
import 'package:ecommerceapp/l10n/localization.dart';
import 'package:ecommerceapp/settings/controller.dart';
import 'package:ecommerceapp/settings/view.dart';
import 'package:ecommerceapp/shared/widgets/icon_button.dart';
import 'package:ecommerceapp/shared/widgets/product.dart';
import 'package:ecommerceapp/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = context.read<HomeController>().scaffoldKey;
    final loading = context.select<HomeController, bool>(
      (controller) => controller.loading,
    );

    return AppScaffold(
      scaffoldKey: _scaffoldKey,
      loading: loading,
      title: Text(AppLocalization.of(context).welcomeTitle),
      leading: AppIconButton(
        icon: const Icon(Icons.menu_rounded),
        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
      ),
      body: Column(
        children: const [
          _HorizontalCategoriesList(),
          SizedBox(height: kDefaultPadding * 1.5),
          _FeaturedProductsGrid(),
        ],
      ),
      drawer: const _Drawer(),
    );
  }
}

class _HorizontalCategoriesList extends StatelessWidget {
  const _HorizontalCategoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = context.select<HomeController, List<Category>>(
      (controller) => controller.categories,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            AppLocalization.of(context).categories,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(
          height: 100.0 * 2,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisExtent: 120,
            ),
            itemBuilder: (context, index) => _CategoryWidget(
              category: categories[index],
            ),
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
          ),
        )
      ],
    );
  }
}

class _FeaturedProductsGrid extends StatelessWidget {
  const _FeaturedProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = context.select<HomeController, List<Product>>(
      (controller) => controller.featuredProducts,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Text(
            AppLocalization.of(context).featuredProducts,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) => ProductWidget(
            product: products[index],
          ),
          itemCount: products.length,
          padding: const EdgeInsets.all(kDefaultPadding),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  final Category category;
  const _CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.select<SettingsController, String>(
      (controller) => controller.locale.languageCode,
    );

    return GestureDetector(
      onTap: () => context.go(
        CategoryView.buildRouteName(category.id),
        extra: category,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            CircleAvatar(
              foregroundImage: CachedNetworkImageProvider(category.image),
              radius: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                category.name[locale],
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 120,
          child: Center(child: Text('profile info goes here')),
        ),
        ListTile(
          title: Text(AppLocalization.of(context).settings),
          leading: const Icon(Icons.settings),
          onTap: () => context.go(SettingsView.routeName),
        )
      ],
    );
  }
}
