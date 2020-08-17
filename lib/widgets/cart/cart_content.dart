import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:groceries_shopping/widgets/cart/cart_expanded_list.dart';
import 'package:groceries_shopping/widgets/cart/cart_next_button.dart';
import 'package:groceries_shopping/widgets/cart/cart_total_price.dart';
import 'package:groceries_shopping/widgets/cart/delivery_charge_indicator.dart';

class CartContent extends StatelessWidget {
  final double animationValue;

  const CartContent({
    Key key,
    @required this.animationValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = Curves.easeInOutExpo.transform(animationValue);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      curve: Interval(0.0, 0.3),
      opacity: animationValue,
      child: FractionalTranslation(
        translation: Offset(0.0, lerpDouble(0.5, 0.0, value)),
        child: _CartContent(),
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment(-1.0, 0.0),
              child: Text(
                'Cart',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      color: AppTheme.whiteTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: const CartExpandedList(),
          ),
          const DeliveryChargeIndicator(),
          const SizedBox(height: 24.0),
          const CartTotalPrice(),
          const SizedBox(height: 24.0),
          const NextButton(),
        ],
      ),
    );
  }
}
