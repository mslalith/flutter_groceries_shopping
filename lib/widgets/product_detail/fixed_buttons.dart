import 'package:flutter/material.dart';
import 'package:groceries_shopping/themes/app_theme.dart';

class FixedButtons extends StatelessWidget {
  final String text;
  final VoidCallback onCartPressed;

  const FixedButtons({
    Key key,
    @required this.text,
    @required this.onCartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(60.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey[400],
                  width: 1.0,
                ),
              ),
              child: Icon(
                Icons.favorite_border,
                size: 18.0,
              ),
            ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: Material(
              color: AppTheme.buttonBackgroundColor,
              borderRadius: BorderRadius.circular(60.0),
              child: InkWell(
                onTap: onCartPressed,
                child: Container(
                  height: 40.0,
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(color: AppTheme.blackTextColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
