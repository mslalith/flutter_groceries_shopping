import 'package:flutter/material.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:provider/provider.dart';

class DeliveryChargeIndicator extends StatelessWidget {
  const DeliveryChargeIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, provider, child) {
        final eligibleForFreeDelivery = provider.eligibleForFreeDelivery;
        final purchasePercentTillFreeDelivery =
            provider.allProductsPrice / provider.deliveryThreshold;
        final priceString = eligibleForFreeDelivery || provider.products.isEmpty
            ? '\$0.00'
            : '\$${provider.deliveryCharge.toStringAsFixed(2)}';
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16.0,
                backgroundColor: Colors.grey[900],
                child: Icon(
                  Icons.traffic,
                  color: AppTheme.buttonBackgroundColor,
                ),
              ),
              const SizedBox(width: 22.0),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: AppTheme.whiteTextColor,
                            // fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      eligibleForFreeDelivery
                          ? 'Eligible for FREE delivery.'
                          : 'All orders of \$${provider.deliveryThreshold} or more are qualified for FREE delivery.',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: AppTheme.whiteTextColor.withOpacity(0.4),
                          ),
                    ),
                    const SizedBox(height: 12.0),
                    if (!eligibleForFreeDelivery)
                      LinearProgressIndicator(
                        minHeight: 3.0,
                        value: purchasePercentTillFreeDelivery,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.buttonBackgroundColor),
                        backgroundColor: Colors.grey[900],
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              const SizedBox(width: 22.0),
              Text(
                priceString,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: AppTheme.whiteTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
