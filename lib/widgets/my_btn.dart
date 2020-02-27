import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool fullWidth;

  final Color backgroundColor, textColor;
  const MyBtn(
      {Key key,
      @required this.label,
      this.onPressed,
      this.backgroundColor,
      this.textColor,
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
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Text(
          this.label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: this.textColor ?? Colors.black,
              fontWeight: FontWeight.w500),
        ),
        decoration: BoxDecoration(
            color: this.backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]),
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        this.onPressed();
      },
    );
  }
}
