import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/src/cart/models.dart';
import 'package:ecommerceapp/src/checkout/model.dart';
import 'package:ecommerceapp/src/shared/services/storage_service.dart';
import 'package:geolocator/geolocator.dart';

class CartService {
  final _firestore = FirebaseFirestore.instance;
  late final _ordersRef = _firestore.collection('orders');
  DocumentReference<Map<String, dynamic>> _cartRef(String userId) =>
      _firestore.collection('carts').doc(userId);

  Future<List<ProductItem>> getItems(String userId) async {
    final snap = await _cartRef(userId).get();
    return List<ProductItem>.from(
      snap.data()?['items']?.map((map) => ProductItem.fromMap(map)) ?? [],
    );
  }

  Future<void> updateItems(String userId, List<ProductItem> items) async {
    _cartRef(userId).set({
      'items': items.map((item) => item.toMap).toList(),
    }, SetOptions(merge: true));
  }

  Future<String> checkout(
    PaymentMethod paymentMethod,
    String userId,
    List<ProductItem> items,
    String? phoneNumber,
    File? transactionImage,
    Position? location,
    String note,
  ) async {
    final imageUrl = transactionImage != null
        ? await StorageService.uploadImage(transactionImage, 'orders/$userId')
        : null;

    final _ref = await _ordersRef.add({
      'paymentMethod': paymentMethod.name,
      'userId': userId,
      'items': items.map((item) => item.toMap).toList(),
      'phoneNumber': phoneNumber,
      'transactionImage': imageUrl,
      'location': location?.toJson(),
      'note': note,
      'createdAt': DateTime.now(),
      'status': 'pending',
    });

    return _ref.id;
  }

  Future<void> clearCart(String userId) => _cartRef(userId).set({});
}
