import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/src/home/models.dart';

class ProductService {
  final _firestore = FirebaseFirestore.instance;

  Stream<Product> streamProduct(String id) => _firestore
      .collection('products')
      .doc(id)
      .snapshots()
      .map((doc) => Product.fromDoc(doc));
}
