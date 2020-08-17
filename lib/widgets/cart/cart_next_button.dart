import 'package:flutter/material.dart';
import 'package:groceries_shopping/themes/app_theme.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      type: MaterialType.button,
      child: Container(
        width: double.infinity,
        height: kToolbarHeight * 0.9,
        child: FlatButton(
          padding: EdgeInsets.zero,
          color: AppTheme.buttonBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          onPressed: () {},
          child: Text(
            'Next',
            style: TextStyle(
              color: AppTheme.blackTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
