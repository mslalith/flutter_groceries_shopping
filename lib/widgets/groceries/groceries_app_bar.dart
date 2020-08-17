import 'package:flutter/material.dart';
import 'package:groceries_shopping/themes/app_theme.dart';

class GroceriesAppBar extends StatelessWidget {
  final double height;

  const GroceriesAppBar({
    Key key,
    this.height = kToolbarHeight * 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment(0.0, 0.5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.contentBackgroundColor,
            AppTheme.contentBackgroundColor.withOpacity(0.7),
            AppTheme.contentBackgroundColor.withOpacity(0.0),
          ],
          stops: [0.7, 0.85, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Material(
              color: Colors.transparent,
              type: MaterialType.circle,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 16.0,
                  color: AppTheme.blackTextColor,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              'Italian Groceries',
              style: TextStyle(
                color: AppTheme.blackTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Material(
              color: Colors.transparent,
              type: MaterialType.circle,
              child: RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.tune,
                    size: 18.0,
                    color: AppTheme.blackTextColor,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
