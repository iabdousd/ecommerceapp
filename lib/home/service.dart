import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/home/models.dart';

class HomeService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Category>> getCategories() async {
    final snap = await _firestore.collection('categories').get();
    return snap.docs.map((doc) => Category.fromDoc(doc)).toList();
  }

  Future<List<Product>> getProducts() async {
    final snap = await _firestore.collection('products').get();
    return snap.docs.map((doc) => Product.fromDoc(doc)).toList();
  }
}
