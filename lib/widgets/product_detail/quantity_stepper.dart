import 'package:flutter/material.dart';

class QuantityStepper extends StatefulWidget {
  final int step;
  final Function(int) onStep;

  const QuantityStepper({
    Key key,
    @required this.step,
    @required this.onStep,
  }) : super(key: key);

  @override
  _QuantityStepperState createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  int step;

  @override
  void initState() {
    super.initState();
    step = widget.step;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey[400],
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              final value = step - 1;
              if (value > 0) {
                setState(() {
                  step = value;
                  widget.onStep(step);
                });
              }
            },
            borderRadius: BorderRadius.circular(60.0),
            child: Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              child: Text('-'),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text('$step'),
          ),
          InkWell(
            onTap: () => setState(() {
              step++;
              widget.onStep(step);
            }),
            borderRadius: BorderRadius.circular(60.0),
            child: Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              child: Text('+'),
            ),
          ),
        ],
      ),
    );
  }
}
