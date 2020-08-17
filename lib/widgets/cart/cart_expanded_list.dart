import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product_quantity.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/widgets/cart/cart_expanded_list_item.dart';
import 'package:provider/provider.dart';

class CartExpandedList extends StatelessWidget {
  const CartExpandedList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, List<ProductQuantity>>(
      selector: (_, provider) => provider.productQuantities,
      builder: (_, productsQuantities, child) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: productsQuantities.length,
          itemBuilder: (_, index) => CartExpandedListItem(
            productQuantity: productsQuantities[index],
          ),
        );
      },
    );
  }
}
