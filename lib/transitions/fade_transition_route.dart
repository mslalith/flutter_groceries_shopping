import 'package:flutter/material.dart';

class FadeTransitionRoute extends PageRouteBuilder {
  final Widget toPage;
  FadeTransitionRoute({
    @required this.toPage,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              toPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final opacity = _opacity(animation);
            return Opacity(
              opacity: opacity,
              child: child,
            );
          },
        );

  static _isPushing(Animation<double> animation) =>
      animation.status == AnimationStatus.forward ||
      animation.status == AnimationStatus.completed;

  static _opacity(Animation<double> animation) {
    final value = animation.value;
    if (_isPushing(animation)) return value;

    final double interval = 0.5;

    if (value < (1.0 - interval)) return 0.0;

    double opacity = (value - (1.0 - interval)) / interval;
    return opacity.clamp(0.0, 1.0);
  }
}
