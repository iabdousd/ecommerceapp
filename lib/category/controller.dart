import 'package:ecommerceapp/category/service.dart';
import 'package:ecommerceapp/home/models.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  final _service = CategoryService();

  Category? category;
  final products = <Product>[];
  bool loading = true;

  CategoryController(String categoryId, Category? category) {
    _init(categoryId, category);
  }

  void _init(String categoryId, Category? category) async {
    this.category = category ?? await _service.getCategory(categoryId);
    notifyListeners();
    products.addAll(await _service.getProducts(categoryId));
    loading = false;
    notifyListeners();
  }
}
