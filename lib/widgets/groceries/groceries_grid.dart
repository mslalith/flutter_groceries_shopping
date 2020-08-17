import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/widgets/groceries/groceries_grid_item.dart';

class GroceriesGrid extends StatelessWidget {
  const GroceriesGrid({
    Key key,
    @required this.products,
    @required this.onProductSelected,
  }) : super(key: key);

  final List<Product> products;
  final Function(Product) onProductSelected;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      mainAxisSpacing: 18.0,
      crossAxisSpacing: 18.0,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(18.0),
      staggeredTileBuilder: (index) =>
          index == 0 ? StaggeredTile.count(4, 0.8) : StaggeredTile.fit(2),
      itemCount: products.length + 1,
      itemBuilder: (_, index) => index == 0
          ? Container()
          : GroceriesGridItem(
              product: products[index - 1],
              onItemSelected: () => onProductSelected(products[index - 1]),
            ),
    );
  }
}
