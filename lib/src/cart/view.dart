import 'package:ecommerceapp/src/cart/controller.dart';
import 'package:ecommerceapp/src/cart/models.dart';
import 'package:ecommerceapp/src/checkout/view.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/settings/controller.dart';
import 'package:ecommerceapp/src/shared/widgets/button.dart';
import 'package:ecommerceapp/src/shared/widgets/empty_list_widget.dart';
import 'package:ecommerceapp/src/shared/widgets/icon_button.dart';
import 'package:ecommerceapp/src/shared/widgets/our_image.dart';
import 'package:ecommerceapp/src/shared/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CartController>();

    return AppScaffold(
      title: Text(AppLocalization.of(context).myCart),
      addPadding: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              AppLocalization.of(context).itemsCount(controller.items.length),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          if (controller.items.isEmpty)
            EmptyListWidget(message: AppLocalization.of(context).emptyCart)
          else ...[
            ListView.builder(
              itemCount: controller.items.length,
              itemBuilder: (context, index) => _CartItemWidget(
                key: ObjectKey(controller.items[index]),
                item: controller.items[index],
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, bottom: 40),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalization.instance.total,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Text(
                  AppLocalization.of(context).priceOf(controller.total),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            AppButton(
              label: AppLocalization.instance.checkout,
              margin: const EdgeInsets.only(top: 16),
              onPressed: () => context.pushNamed(CheckoutView.routeName),
            ),
          ]
        ],
      ),
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  final ProductItem item;
  const _CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CartController>();
    final locale = SettingsController.localeOf(context).languageCode;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImage(
            uri: item.product.image,
            height: 120,
            width: 120,
            borderRadius: BorderRadius.circular(12),
          ),
          Expanded(
            child: Container(
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    item.product.name[locale],
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      AppLocalization.instance.priceOf(item.product.price),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Row(
                    children: [
                      AppIconButton(
                        onPressed: () => controller.decrease(item),
                        icon: const FaIcon(FontAwesomeIcons.minus, size: 20),
                        margin: EdgeInsets.zero,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${item.quantity}',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      AppIconButton(
                        onPressed: () => controller.increase(item),
                        icon: const FaIcon(FontAwesomeIcons.plus, size: 20),
                        margin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
