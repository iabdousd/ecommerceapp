import 'package:ecommerceapp/src/cart/controller.dart';
import 'package:ecommerceapp/src/home/models.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/product/controller.dart';
import 'package:ecommerceapp/src/settings/controller.dart';
import 'package:ecommerceapp/src/shared/widgets/button.dart';
import 'package:ecommerceapp/src/shared/widgets/our_image.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  static const routeName = 'products/:productId';

  final String productId;
  final Product? product;
  const ProductView({Key? key, required this.productId, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductController>(
      create: (_) => ProductController(productId, product),
      child: const _ProductView(),
    );
  }
}

class _ProductView extends StatelessWidget {
  const _ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductController>();
    final locale = SettingsController.localeOf(context).languageCode;
    final product = controller.product;

    return AppScaffold(
      loading: controller.loading,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppImage(
            uri: product!.image,
            height: MediaQuery.of(context).size.width / 1.5,
            width: double.infinity,
            fit: BoxFit.cover,
            zoomable: false,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name[locale],
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 12),
                  child: Text(
                    AppLocalization.of(context).priceOf(product.price),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Wrap(
                  children: product.metadatas.map(
                    (metadata) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                          children: [
                            Text(
                              '${metadata.title[locale]}: ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              metadata.value[locale],
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        AppButton(
          label: AppLocalization.of(context).addToCart,
          onPressed: () => context.read<CartController>().add(product),
        ),
      ],
    );
  }
}
