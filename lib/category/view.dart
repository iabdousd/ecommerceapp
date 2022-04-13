import 'package:ecommerceapp/configs/theme.dart';
import 'package:ecommerceapp/home/models.dart';
import 'package:ecommerceapp/settings/controller.dart';
import 'package:ecommerceapp/shared/widgets/product.dart';
import 'package:ecommerceapp/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller.dart';

class CategoryView extends StatelessWidget {
  static const routeName = '/category/:id';
  static String buildRouteName(String id) => routeName.replaceFirst(':id', id);

  final String categoryId;
  final Category? category;
  const CategoryView({Key? key, required this.categoryId, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryController>(
      create: (_) => CategoryController(categoryId, category),
      child: const _CategoryView(),
    );
  }
}

class _CategoryView extends StatelessWidget {
  const _CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CategoryController>();
    final locale = SettingsController.localeOf(context);

    return AppScaffold(
      title: Text(controller.category?.name[locale.languageCode] ?? ''),
      loading: controller.loading,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) => ProductWidget(
          product: controller.products[index],
        ),
        itemCount: controller.products.length,
        padding: const EdgeInsets.all(kDefaultPadding),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
