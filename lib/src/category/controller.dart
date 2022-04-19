import 'dart:async';

import 'package:ecommerceapp/src/category/service.dart';
import 'package:ecommerceapp/src/home/models.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  final _service = CategoryService();

  Category? category;
  List<Product> products = [];
  bool loading = true;
  StreamSubscription? productsStream;

  CategoryController(String categoryId, Category? category) {
    _init(categoryId, category);
  }

  void _init(String categoryId, Category? category) async {
    this.category = category ?? await _service.getCategory(categoryId);
    notifyListeners();
    productsStream = _service.streamProducts(categoryId).listen((products) {
      this.products = products;
      loading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    productsStream?.cancel();
    super.dispose();
  }
}
