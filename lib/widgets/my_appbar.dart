import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_app_2/pages/chat_page.dart';

class MyAppbar extends StatelessWidget {
  final String leftIcon, rightIcon;
  final VoidCallback onLeftClick, onRightClick;

  MyAppbar(
      {Key key,
      @required this.leftIcon,
      @required this.rightIcon,
      this.onLeftClick,
      this.onRightClick})
      : super(key: key);

  // 'https://image.flaticon.com/icons/svg/685/685662.svg'
  // 'https://image.flaticon.com/icons/svg/126/126501.svg',

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            onPressed: onLeftClick,
            padding: EdgeInsets.all(15),
            child: SvgPicture.network(
              leftIcon,
              width: 30,
            ),
          ),
          Text("LOGO",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          CupertinoButton(
            onPressed: onRightClick,
            padding: EdgeInsets.all(0),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SvgPicture.network(
                    rightIcon,
                    width: 30,
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
