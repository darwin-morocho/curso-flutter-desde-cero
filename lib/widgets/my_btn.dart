import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;
  final EdgeInsets padding;

  final Color backgroundColor, textColor;
  const MyBtn(
      {Key key,
      @required this.label,
      this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.padding,
      this.fullWidth = false})
      : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 30,
      padding: EdgeInsets.zero,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding:
            this.padding ?? EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        child: Text(
          this.label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: this.textColor ?? Colors.black,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5),
        ),
        decoration: BoxDecoration(
            color: this.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, blurRadius: 10, offset: Offset(0, 5))
            ]),
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        this.onPressed();
      },
    );
  }
}
