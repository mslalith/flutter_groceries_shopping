import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/models/product_quantity.dart';

class CartProvider extends ChangeNotifier {
  Set<Product> _products = <Product>{};
  Set<Product> get products => _products;

  bool isAlreadyInCart(int productId) =>
      _products.any((p) => p.id == productId);
  List<ProductQuantity> get productQuantities => _products
      .map(
        (p) => ProductQuantity(
          quantity: quantityOf(p.id),
          product: p,
        ),
      )
      .toList();

  double _deliveryThreshold = 40.0;
  double get deliveryThreshold => _deliveryThreshold;

  double _deliveryCharge = 30.0;
  double get deliveryCharge => _deliveryCharge;

  bool get eligibleForFreeDelivery => _allProductsPrice >= _deliveryThreshold;

  bool _isProductAddedToCart = false;
  bool get isProductAddedToCart => _isProductAddedToCart;
  set isProductAddedToCart(bool value) {
    if (_isProductAddedToCart == value) return;
    _isProductAddedToCart = value;
  }

  Map<int, int> _productQuantities = {};
  int quantityOf(int productId) => _productQuantities[productId] ?? 0;

  double totalPriceOf(int productId) {
    final product = _products.firstWhere((p) => p.id == productId);
    return product.price * quantityOf(productId);
  }

  double _allProductsPrice = 0.0;
  double get allProductsPrice => _allProductsPrice;

  double get totalPrice {
    final price = _allProductsPrice;
    if (_products.isEmpty) return 0.0;

    return price < _deliveryThreshold ? price + _deliveryCharge : price;
  }

  void addToCart(Product product, quantity) {
    _products.add(product);
    _productQuantities[product.id] = quantity;
    _allProductsPrice += quantity * product.price;
    _isProductAddedToCart = true;
  }

  void updateCart(int productId, int quantity) {
    final previousQuantity = _productQuantities[productId];
    final price = _products.firstWhere((p) => p.id == productId).price;
    _productQuantities[productId] = quantity;

    final changeInQuantity = previousQuantity - quantity;
    if (changeInQuantity > 0) {
      _allProductsPrice -= changeInQuantity * price;
    } else {
      _allProductsPrice += changeInQuantity.abs() * price;
    }
  }

  void removeFromCart(Product product) {
    final quantity = _productQuantities[product.id];
    _allProductsPrice -= quantity * product.price;
    _productQuantities.remove(product.id);
    _products.remove(product);
  }
}
