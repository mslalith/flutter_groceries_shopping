import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/themes/app_theme.dart';

class CartFooterListItem extends StatelessWidget {
  final Product product;

  const CartFooterListItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Hero(
        tag: 'animation_id_${product.id}',
        child: CircleAvatar(
          radius: 16.0,
          backgroundColor: AppTheme.contentBackgroundColor,
          child: Image.asset(
            product.imagePath,
            width: 16.0,
          ),
        ),
      ),
    );
  }
}
