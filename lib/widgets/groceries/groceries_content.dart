import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/pages/product_detail.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:groceries_shopping/transitions/fade_transition_route.dart';
import 'package:groceries_shopping/widgets/groceries/groceries_app_bar.dart';
import 'package:groceries_shopping/widgets/groceries/groceries_grid.dart';
import 'package:provider/provider.dart';

class GroceriesContent extends StatelessWidget {
  final List<Product> products;

  const GroceriesContent({
    Key key,
    @required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(24.0),
      ),
      child: Container(
        color: AppTheme.contentBackgroundColor,
        child: Stack(
          children: [
            GroceriesGrid(
              products: products,
              onProductSelected: (product) => _onProductSelected(
                context,
                product,
              ),
            ),
            const GroceriesAppBar(),
            const GridBottomMask(),
          ],
        ),
      ),
    );
  }

  void _onProductSelected(
    BuildContext context,
    Product product,
  ) {
    Navigator.of(context).push(
      FadeTransitionRoute(
        toPage: ChangeNotifierProvider.value(
          value: Provider.of<CartProvider>(context, listen: false),
          child: ProductDetail(product: product),
        ),
      ),
    );
  }
}

class GridBottomMask extends StatelessWidget {
  const GridBottomMask({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 36.0,
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.contentBackgroundColor,
              AppTheme.contentBackgroundColor.withOpacity(0.7),
              AppTheme.contentBackgroundColor.withOpacity(0.0),
            ],
            stops: [0.3, 0.7, 1.0],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
    );
  }
}
