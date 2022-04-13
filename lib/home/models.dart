import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerceapp/shared/models/intl_field.dart';

class Category {
  final String id;
  final IntlField name;
  final String image;

  const Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) throw Exception('Data of ${doc.reference.path} is null');

    return Category(
      id: doc.id,
      name: IntlField.fromMap(data['name']),
      image: data['image'],
    );
  }
}

class Product {
  final String id;
  final IntlField name;
  final String image;
  final double price;
  final List<ProductMetaData> metadatas;

  const Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.metadatas,
  });

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name.toMap,
        'image': image,
        'price': price,
        'metadatas': metadatas.map((x) => x.toMap).toList(),
      };

  factory Product.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return Product(
      id: doc.id,
      name: IntlField.fromMap(data['name']),
      image: data['image'],
      price: data['price'].toDouble(),
      metadatas: List<ProductMetaData>.from(
        data['metadatas']?.map((x) => ProductMetaData.fromMap(x)),
      ),
    );
  }
}

class ProductVariation {
  final String id;
  final IntlField name;
  final double price;
  final String? image;

  const ProductVariation({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}

class ProductMetaData {
  final IntlField title;
  final IntlField value;
  final String? icon;

  ProductMetaData({required this.title, required this.value, this.icon});

  Map<String, dynamic> get toMap => {
        'title': title.toMap,
        'value': value.toMap,
      };

  factory ProductMetaData.fromMap(Map<String, dynamic> map) {
    return ProductMetaData(
      title: IntlField.fromMap(map['title']),
      value: IntlField.fromMap(map['value']),
    );
  }
}
