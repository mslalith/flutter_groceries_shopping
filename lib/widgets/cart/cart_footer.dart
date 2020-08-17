import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:groceries_shopping/widgets/cart/cart_footer_list.dart';
import 'package:provider/provider.dart';

class CartFooter extends StatelessWidget {
  final double animationValue;

  const CartFooter({
    Key key,
    @required this.animationValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Color.lerp(
        AppTheme.cartBackgroundColor,
        Colors.transparent,
        animationValue,
      ),
      child: Selector<CartProvider, Set<Product>>(
        selector: (_, provider) => provider.products,
        builder: (_, products, child) {
          return Row(
            children: [
              Opacity(
                opacity: 1.0 - animationValue,
                child: Container(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Cart',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: AppTheme.whiteTextColor,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Opacity(
                  opacity: 1.0 - animationValue,
                  child: CartFooterList(
                    products: products.toList(),
                  ),
                ),
              ),
              Transform.scale(
                scale: 1.0 - animationValue,
                child: CircleAvatar(
                  backgroundColor: AppTheme.buttonBackgroundColor,
                  child: Text(
                    products.length.toString(),
                    style: TextStyle(color: AppTheme.blackTextColor),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
