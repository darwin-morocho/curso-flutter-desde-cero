import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginTextFormField extends StatelessWidget {
  final FocusNode focusNode;
  final String iconPath, initialValue, hintText, labelText;
  final String Function(String) validator;
  final void Function(String) onFieldSubmitted;
  final bool obscureText;

  LoginTextFormField(
      {Key key,
      @required this.iconPath,
      this.initialValue = '',
      this.hintText='',
      this.labelText='',
      this.validator,
      this.focusNode,
      this.obscureText=false,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: this.hintText,
          labelText: this.labelText,
          prefixIcon: Container(
            width: 70,
            height: 40,
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(this.iconPath, color: Colors.black54),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.light,
      textInputAction: TextInputAction.next,
      validator: this.validator,
      focusNode: this.focusNode,
      onFieldSubmitted: this.onFieldSubmitted,
      initialValue: this.initialValue,
      obscureText: this.obscureText,
    );
  }
}
