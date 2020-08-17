import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/themes/app_theme.dart';

class GroceriesGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback onItemSelected;

  const GroceriesGridItem({
    Key key,
    @required this.product,
    @required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: onItemSelected,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'id_${product.id}',
                child: AspectRatio(
                  aspectRatio: 0.75,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      product.imagePath,
                      width: 120.0,
                    ),
                  ),
                ),
              ),
              Text(
                '\$${product.price}',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: AppTheme.blackTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16.0),
              Text(
                product.name,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppTheme.blackTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4.0),
              Text(
                product.weight,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
