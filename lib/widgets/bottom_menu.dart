import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomMenuItem {
  final String iconPath, label;

  BottomMenuItem({@required this.iconPath, @required this.label});
}

class BottomMenu extends StatelessWidget {
  final List<BottomMenuItem> items;

  BottomMenu({@required this.items})
      : assert(items != null && items.length > 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final BottomMenuItem item = items[index];
          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(
                  item.iconPath,
                  width: 35,
                ),
                SizedBox(height: 3),
                Text(
                  item.label,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                )
              ],
            ),
          );
        }),
      )),
    );
  }
}
