import 'package:flutter/material.dart';

class ClearButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String buttonText;

  const ClearButtonWidget({
    Key key,
    this.onPressed,
    @required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: this.onPressed,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: Text(
          this.buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
