import 'package:ecommerceapp/src/home/models.dart';

class ProductItem {
  final Product product;
  final int quantity;

  const ProductItem({required this.product, required this.quantity});

  Map<String, dynamic> get toMap => {
        'product': product.toMap,
        'quantity': quantity,
      };

  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      product: Product.fromMap(map['product']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  @override
  String toString() => 'ProductItem(product: $product, quantity: $quantity)';

  @override
  bool operator ==(Object other) =>
      other is ProductItem &&
      other.product == product &&
      other.quantity == quantity;

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  ProductItem copyWith({Product? product, int? quantity}) => ProductItem(
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
      );
}
