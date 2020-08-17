import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product_quantity.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:provider/provider.dart';

class CartExpandedListItem extends StatelessWidget {
  final ProductQuantity productQuantity;

  const CartExpandedListItem({
    Key key,
    @required this.productQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final price = Provider.of<CartProvider>(
      context,
      listen: false,
    ).totalPriceOf(productQuantity.product.id).toStringAsFixed(2);

    return Container(
      height: kToolbarHeight,
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.0,
            backgroundColor: AppTheme.contentBackgroundColor,
            child: Image.asset(
              productQuantity.product.imagePath,
              width: 16.0,
            ),
          ),
          const SizedBox(width: 22.0),
          Text(
            '${productQuantity.quantity}',
            style: TextStyle(
              color: AppTheme.whiteTextColor,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            'x',
            style: TextStyle(
              color: AppTheme.whiteTextColor,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              '${productQuantity.product.name}',
              maxLines: 2,
              style: TextStyle(
                color: AppTheme.whiteTextColor,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            '\$$price',
            style: TextStyle(
              color: AppTheme.whiteTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
