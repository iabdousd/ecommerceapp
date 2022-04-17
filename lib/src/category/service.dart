import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/src/home/models.dart';

class CategoryService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProducts(String categoryId) async {
    final productsSnap = await _firestore
        .collection('products')
        .where('categories', arrayContains: categoryId)
        .get();

    return productsSnap.docs.map(Product.fromDoc).toList();
  }

  Future<Category> getCategory(String categoryId) async {
    final doc = await _firestore.collection('categories').doc(categoryId).get();
    return Category.fromDoc(doc);
  }
}
