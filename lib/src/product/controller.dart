import 'dart:async';

import 'package:ecommerceapp/src/home/models.dart';
import 'package:ecommerceapp/src/product/service.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final _service = ProductService();
  final String productId;
  StreamSubscription? _subscription;
  Product? _product;
  Product? get product => _product;
  bool loading = true;

  ProductController(this.productId, this._product) {
    _init();
  }

  void _init() async {
    loading = product == null;
    _subscription = _service.streamProduct(productId).listen((product) {
      _product = product;
      loading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
