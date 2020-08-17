import 'package:flutter/material.dart';
import 'package:groceries_shopping/themes/app_theme.dart';

class MobileView extends StatelessWidget {
  final Widget child;
  final double mobileAspectRatio;
  final EdgeInsets margin;

  const MobileView({
    Key key,
    @required this.child,
    this.mobileAspectRatio = 9 / 18,
    this.margin = const EdgeInsets.all(24.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36.0),
          border: Border.all(
            color: AppTheme.cartBackgroundColor,
            width: 4.0,
          ),
        ),
        child: AspectRatio(
          aspectRatio: mobileAspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
