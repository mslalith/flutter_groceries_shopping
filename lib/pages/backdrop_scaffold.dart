import 'package:flutter/material.dart';
import 'package:groceries_shopping/providers/cart_provider.dart';
import 'package:groceries_shopping/themes/app_theme.dart';
import 'package:provider/provider.dart';

class BackdropScaffold extends StatefulWidget {
  final Widget frontContent;
  final Widget Function(double) backContentBuilder;
  final Widget Function(double) footerBuilder;

  const BackdropScaffold({
    Key key,
    @required this.frontContent,
    @required this.backContentBuilder,
    @required this.footerBuilder,
  }) : super(key: key);

  @override
  _BackdropScaffoldState createState() => _BackdropScaffoldState();
}

class _BackdropScaffoldState extends State<BackdropScaffold>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController addToCartController;
  double appHeight = 0.0;
  double contentHeight = 0.0;
  double footerHeight = 90.0;
  double dragStart;
  BackdropContentState contentState;

  @override
  void initState() {
    super.initState();
    contentState = BackdropContentState.front;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() => setState(() {}));

    addToCartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Provider.of<CartProvider>(
            context,
            listen: false,
          ).isProductAddedToCart = false;
          addToCartController.reset();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    addToCartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isProductAddedToCart =
        context.watch<CartProvider>().isProductAddedToCart;
    final shouldShowAddToCartAnimation =
        isProductAddedToCart && !_isAddToCartControllerAnimating;

    if (shouldShowAddToCartAnimation) {
      addToCartController.forward(from: 0.0);
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          appHeight = constraints.maxHeight;
          contentHeight = appHeight - footerHeight;

          final Tween<double> frontContentHeightTween = Tween<double>(
            begin: footerHeight,
            end: footerHeight + (appHeight - footerHeight * 2),
          );
          final Tween<double> frontContentAddToCartTween = Tween<double>(
            begin: 0.0,
            end: footerHeight,
          );
          final Tween<double> backContentHeightTween = Tween<double>(
            begin: appHeight,
            end: footerHeight,
          );
          final Tween<double> backContentTranslateTween = Tween<double>(
            begin: -contentHeight,
            end: 0.0,
          );
          final value = controller.value;

          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: AppTheme.cartBackgroundColor),
              ),
              if (_isBackContentVisible)
                Positioned(
                  top: backContentHeightTween.transform(value),
                  bottom: backContentTranslateTween.transform(value),
                  left: 0.0,
                  right: 0.0,
                  child: GestureDetector(
                    onVerticalDragStart: _onVerticalBackContentDragStart,
                    onVerticalDragUpdate: _onVerticalBackContentDragUpdate,
                    onVerticalDragEnd: _onVerticalBackContentDragEnd,
                    child: widget.backContentBuilder(value),
                  ),
                ),
              Positioned(
                top: contentHeight,
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: GestureDetector(
                  onVerticalDragStart: _onVerticalFooterDragStart,
                  onVerticalDragUpdate: _onVerticalFooterDragUpdate,
                  onVerticalDragEnd: _onVerticalFooterDragEnd,
                  child: widget.footerBuilder(value),
                ),
              ),
              Positioned(
                top: 0.0,
                bottom: _isAddToCartControllerAnimating
                    ? frontContentAddToCartTween
                        .transform(addToCartController.value)
                    : frontContentHeightTween.transform(value),
                left: 0.0,
                right: 0.0,
                child: widget.frontContent,
              ),
            ],
          );
        },
      ),
    );
  }

  bool get _isAddToCartControllerAnimating =>
      addToCartController.status == AnimationStatus.forward ||
      addToCartController.status == AnimationStatus.completed;

  bool get _isBackContentVisible =>
      contentState == BackdropContentState.back ||
      contentState == BackdropContentState.toFront;
  bool get _isFrontContentVisible =>
      contentState == BackdropContentState.front ||
      contentState == BackdropContentState.toBack;

  void _onVerticalFooterDragStart(DragStartDetails details) {
    dragStart = details.globalPosition.dy;
    contentState = BackdropContentState.toBack;
  }

  void _onVerticalFooterDragUpdate(DragUpdateDetails details) {
    if (_isBackContentVisible) return;

    final offset = details.globalPosition.dy - dragStart;
    if (offset > 0) return;

    final value = offset.abs() / contentHeight;
    controller.value += value / 100;
  }

  void _onVerticalFooterDragEnd(DragEndDetails details) {
    if (_isBackContentVisible) return;

    dragStart = null;
    if (controller.value > 0.0) {
      controller.animateTo(1.0);
    }
    contentState = BackdropContentState.back;
  }

  void _onVerticalBackContentDragStart(DragStartDetails details) {
    dragStart = details.globalPosition.dy;
    contentState = BackdropContentState.toFront;
  }

  void _onVerticalBackContentDragUpdate(DragUpdateDetails details) {
    if (_isFrontContentVisible) return;

    final offset = details.globalPosition.dy - dragStart;
    final value = offset / contentHeight;
    controller.value -= value / 100;
  }

  void _onVerticalBackContentDragEnd(DragEndDetails details) {
    if (_isFrontContentVisible) return;

    dragStart = null;
    if (controller.value > 0.0) {
      controller.animateBack(0.0);
    }
    contentState = BackdropContentState.front;
  }
}

enum BackdropContentState {
  front,
  toFront,
  back,
  toBack,
}
