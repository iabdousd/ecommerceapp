import 'package:ecommerceapp/home/service.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class HomeController with ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _service = HomeService();
  bool loading;
  List<Category> categories = [];
  List<Product> featuredProducts = [];

  HomeController() : loading = true {
    init();
  }

  init() async {
    await Future.wait([
      _service.getCategories().then((value) => categories = value),
      _service.getProducts().then((value) => featuredProducts = value)
    ]);
    loading = false;
    notifyListeners();
  }
}
