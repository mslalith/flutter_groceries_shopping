import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/pages/backdrop_scaffold.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:groceries_shopping/widgets/cart/cart_content.dart';
import 'package:groceries_shopping/widgets/cart/cart_footer.dart';
import 'package:groceries_shopping/widgets/groceries/groceries_content.dart';
import 'package:groceries_shopping/widgets/mobile_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groceries Shopping',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.cartBackgroundColor,
        fontFamily: 'WorkSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileView(
      child: BackdropScaffold(
        frontContent: GroceriesContent(products: products),
        backContentBuilder: (double animationValue) => CartContent(
          animationValue: animationValue,
        ),
        footerBuilder: (double animationValue) => CartFooter(
          animationValue: animationValue,
        ),
      ),
    );
  }
}
