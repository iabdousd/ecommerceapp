import 'package:ecommerceapp/src/configs/theme.dart';
import 'package:ecommerceapp/src/home/models.dart';
import 'package:ecommerceapp/src/product/view.dart';
import 'package:ecommerceapp/src/settings/controller.dart';
import 'package:ecommerceapp/src/shared/widgets/our_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final String? categoryId;
  const ProductWidget({Key? key, required this.product, this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.select<SettingsController, String>(
      (controller) => controller.locale.languageCode,
    );

    return GestureDetector(
      onTap: () => context.pushNamed(
        ProductView.routeName,
        params: {'productId': product.id},
        extra: product,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [DefaultBoxShadow()],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                product.name[locale],
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 1,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppImage(
                  uri: product.image,
                  borderRadius: BorderRadius.circular(12),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
