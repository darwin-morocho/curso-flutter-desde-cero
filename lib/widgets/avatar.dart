import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'circle_container.dart';

class Avatar extends StatefulWidget {
  final double size;

  const Avatar({Key key, this.size=150}) : super(key: key);
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  File _file;

  _pickImage() async {
    final File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _file = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: <Widget>[
          _file == null
              ? SvgPicture.network(
                  'https://image.flaticon.com/icons/svg/1177/1177568.svg')
              : ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    _file,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
          Positioned(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 30,
              onPressed: _pickImage,
              child: CircleContainer(
                child: Icon(Icons.edit),
                size: 60,
              ),
            ),
            right: 0,
            top: 0,
          )
        ],
      ),
    );
  }
}
