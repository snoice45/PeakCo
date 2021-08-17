import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;

  CustomBtn({
    required this.text,
    required this.onPressed,
    required this.outlineBtn,
  });

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn;

    return GestureDetector(
      onTap: onPressed(),
      child: Container(
        height: 65.0,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(
            12.0,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Visibility(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outlineBtn ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
