import 'package:flutter/material.dart';

class OnboardigButton extends StatelessWidget {
  const OnboardigButton({required this.onTap, this.width = 160});

  final VoidCallback onTap;

  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
// ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: onTap,
        color: Color.fromRGBO(106, 175, 63, 1),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Text(
          'Продолжить',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SFBold',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
