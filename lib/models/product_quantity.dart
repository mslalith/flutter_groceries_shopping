import 'package:flutter/material.dart' show required;
import 'package:groceries_shopping/models/product.dart';

class ProductQuantity {
  final int quantity;
  final Product product;

  const ProductQuantity({
    @required this.quantity,
    @required this.product,
  });
}
