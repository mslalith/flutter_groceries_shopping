import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:groceries_shopping/widgets/cart/cart_footer_list_item.dart';

class CartFooterList extends StatelessWidget {
  final List<Product> products;

  const CartFooterList({
    Key key,
    @required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: products.length,
          itemBuilder: (_, index) => CartFooterListItem(
            product: products[index],
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          right: -1.0,
          width: 24.0,
          child: _mask(isLeft: true),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: -1.0,
          width: 24.0,
          child: _mask(isLeft: false),
        ),
      ],
    );
  }

  Widget _mask({bool isLeft = true}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.cartBackgroundColor,
            AppTheme.cartBackgroundColor.withOpacity(0.6),
            AppTheme.cartBackgroundColor.withOpacity(0.0),
          ],
          stops: [0.4, 0.7, 1.0],
          begin: isLeft ? Alignment.centerRight : Alignment.centerLeft,
          end: isLeft ? Alignment.centerLeft :Alignment.centerRight,
        ),
      ),
    );
  }
}
