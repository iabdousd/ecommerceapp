import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/configs/theme.dart';
import 'package:ecommerceapp/home/models.dart';
import 'package:ecommerceapp/settings/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.select<SettingsController, String>(
      (controller) => controller.locale.languageCode,
    );

    return Container(
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
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(product.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
