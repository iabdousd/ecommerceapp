import 'dart:io';

import 'package:ecommerceapp/src/cart/models.dart';
import 'package:ecommerceapp/src/cart/service.dart';
import 'package:ecommerceapp/src/checkout/model.dart';
import 'package:ecommerceapp/src/home/models.dart';
import 'package:ecommerceapp/src/l10n/localization.dart';
import 'package:ecommerceapp/src/orders/views/details.dart';
import 'package:ecommerceapp/src/services/exceptions.dart';
import 'package:ecommerceapp/src/services/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class CartController extends ChangeNotifier {
  final String? userId;
  final _service = CartService();
  CartController(this.userId) {
    _init();
  }

  final checkoutFormKey = GlobalKey<FormState>();
  String? phoneNumber;
  String note = '';
  File? transactionImage;
  Position? location;
  PaymentMethod _selectedMethod = PaymentMethod.bankily;
  PaymentMethod get paymentMethod => _selectedMethod;
  set paymentMethod(PaymentMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }

  List<ProductItem> items = [];

  void _init() async {
    if (userId != null) {
      items = await _service.getItems(userId!);
      notifyListeners();
    }
  }

  Future<void> _storeCart() {
    if (userId != null) return _service.updateItems(userId!, items);
    return Future.value();
  }

  double get total =>
      items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  int _indexOf(Product product) =>
      items.indexWhere((item) => item.product.id == product.id);

  bool present(Product product) => _indexOf(product) != -1;

  void add(Product product) => ExceptionsHandler.handle(() async {
        final index = _indexOf(product);

        if (index == -1) {
          items.add(ProductItem(product: product, quantity: 1));
        } else {
          increase(items[index]);
        }

        notifyListeners();
        Flushbar.showSuccess(AppLocalization.instance.addedToCart);
        _storeCart();
      });

  void decrease(ProductItem item) {
    if (item.quantity == 1) {
      items.remove(item);
    } else {
      items[items.indexOf(item)] = item.copyWith(quantity: item.quantity - 1);
    }
    notifyListeners();
    _storeCart();
  }

  void increase(ProductItem item) {
    items[items.indexOf(item)] = item.copyWith(quantity: item.quantity + 1);
    notifyListeners();
    _storeCart();
  }

  Future<void> clearCart() async {
    await _service.clearCart(userId!);
    phoneNumber = null;
    transactionImage = null;
    location = null;
    note = '';
    items.clear();
    notifyListeners();
  }

  void checkout(BuildContext context) async {
    if (!checkoutFormKey.currentState!.validate()) return;
    EasyLoading.show();
    final orderId = await _service.checkout(
      paymentMethod,
      userId!,
      items,
      phoneNumber,
      transactionImage,
      location,
      note,
    );

    await clearCart();

    EasyLoading.dismiss();
    context.goNamed(OrderView.routeName, params: {'orderId': orderId});
  }
}
