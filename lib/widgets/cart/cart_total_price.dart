import 'package:flutter/material.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:provider/provider.dart';

class CartTotalPrice extends StatelessWidget {
  const CartTotalPrice({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total:',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: AppTheme.whiteTextColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        Selector<CartProvider, double>(
          selector: (_, provider) => provider.totalPrice,
          builder: (_, totalPrice, child) {
            final price = totalPrice.toStringAsFixed(2);
            return Text(
              '\$$price',
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: AppTheme.whiteTextColor,
                    fontWeight: FontWeight.bold,
                  ),
            );
          }
        ),
      ],
    );
  }
}
