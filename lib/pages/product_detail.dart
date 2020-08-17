import 'package:flutter/material.dart';
import 'package:groceries_shopping/models/product.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:groceries_shopping/widgets/mobile_view.dart';
import 'package:groceries_shopping/widgets/product_detail/fixed_buttons.dart';
import 'package:groceries_shopping/widgets/product_detail/quantity_stepper.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  String heroTag;
  CartProvider provider;
  int previousQuantity;
  ValueNotifier<int> currentQuantity;
  bool isAlreadyInCart;

  @override
  void initState() {
    super.initState();
    heroTag = 'id_${widget.product.id}';
    provider = Provider.of<CartProvider>(context, listen: false);
    isAlreadyInCart = provider.isAlreadyInCart(widget.product.id);
    previousQuantity = provider.quantityOf(widget.product.id);
    currentQuantity = ValueNotifier(previousQuantity);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() => setState(() {}));
    controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileView(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16.0,
              color: AppTheme.cartBackgroundColor,
            ),
            onPressed: _goBack,
          ),
        ),
        body: Transform.translate(
          offset: Offset(
            0.0,
            -50.0 * (1.0 - controller.value),
          ),
          child: Opacity(
            opacity:
                controller.value < 0.5 ? 0.0 : (controller.value - 0.5) / 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 36.0),
                              Hero(
                                tag: heroTag,
                                child: Container(
                                  height: 240.0,
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    widget.product.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 36.0),
                              Text(
                                widget.product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                      color: AppTheme.blackTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 12.0),
                              Text(
                                widget.product.weight,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              const SizedBox(height: 36.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  QuantityStepper(
                                    step: previousQuantity == 0
                                        ? 1
                                        : previousQuantity,
                                    onStep: (int quantity) {
                                      currentQuantity.value = quantity;
                                    },
                                  ),
                                  Text(
                                    '\$9.99',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                          color: AppTheme.blackTextColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 36.0),
                              Text(
                                'About the product',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: AppTheme.blackTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                widget.product.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                              const SizedBox(height: 36.0),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        height: 36.0,
                        top: -1.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.75),
                                Colors.white.withOpacity(0.0),
                              ],
                              stops: [0.5, 0.75, 1.0],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 36.0,
                        bottom: -1.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.75),
                                Colors.white.withOpacity(0.0),
                              ],
                              stops: [0.5, 0.75, 1.0],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: currentQuantity,
                  builder: (_, int value, child) {
                    return FixedButtons(
                      text: _cartButtonText(value),
                      onCartPressed: _onCartPressed,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCartPressed() {
    final quantity = currentQuantity.value;
    if (isAlreadyInCart) {
      if (previousQuantity != quantity) {
        provider.updateCart(widget.product.id, quantity);
      } else {
        provider.removeFromCart(widget.product);
      }
    } else {
      provider.addToCart(widget.product, quantity == 0 ? 1 : quantity);
      setState(() => heroTag = 'animation_id_${widget.product.id}');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _goBack());
  }

  String _cartButtonText(int value) {
    String text = 'Add to cart';
    if (isAlreadyInCart) {
      text = previousQuantity != value ? 'Update cart' : 'Remove from cart';
    }
    return text;
  }

  void _goBack() {
    controller.reverse();
    Navigator.of(context).pop();
  }
}
