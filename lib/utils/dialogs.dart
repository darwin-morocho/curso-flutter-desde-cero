import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> alert(BuildContext context,
      {String title, String body, String okText = "Aceptar"}) async {
    Completer<void> c = Completer();

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: body != null ? Text(body) : null,
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(okText),
                onPressed: () {
                  Navigator.pop(context);
                  c.complete();
                },
              )
            ],
          );
        });

    return c.future;
  }

  static Future<bool> confirm(BuildContext context,
      {String title,
      String body,
      String confirmText = "Aceptar",
      String cancelText = "Cancelar"}) async {
    final Completer<bool> c = Completer();

    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            child: CupertinoActionSheet(
              title: title != null
                  ? Text(
                      title,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  : null,
              message: body != null
                  ? Text(body, style: TextStyle(fontSize: 16))
                  : null,
              actions: <Widget>[
                CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      c.complete(true);
                    },
                    child: Text(
                      confirmText,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                    )),
              ],
              cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    c.complete(false);
                  },
                  child: Text(
                    cancelText,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.w300),
                  )),
            ),
          );
        });

    return c.future;
  }

  static void intput(BuildContext context,
      {String label,
      String placeholder,
      @required void Function(String) onOk}) {
    String text = '';

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: label != null ? Text(label) : null,
            content: CupertinoTextField(
              onChanged: (String _text) {
                text = _text;
              },
              placeholder: placeholder,
            ),
            actions: <Widget>[
              CupertinoButton(
                child: Text("Aceptar"),
                onPressed: () {
                  Navigator.pop(context);
                  onOk(text);
                },
              )
            ],
          );
        });
  }

  static void intputEmail(BuildContext context,
      {String label,
      String placeholder,
      @required void Function(String) onOk}) {
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: label != null
                ? Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(label),
                  )
                : null,
            content: InputEmail(
              placeholder: placeholder,
              onOk: (text) {
                if (onOk != null) {
                  onOk(text);
                }
              },
            ),
          );
        });
  }
}

class InputEmail extends StatefulWidget {
  final String placeholder;
  final void Function(String) onOk;

  InputEmail({Key key, this.placeholder, @required this.onOk})
      : super(key: key);
  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  String _email = '';

  bool _validate() {
    return _email.contains("@");
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _validate();

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CupertinoTextField(
            onChanged: (String text) {
              _email = text;
              _validate();
              setState(() {});
            },
            placeholder: widget.placeholder,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.red),
                    )),
              ),
              Expanded(
                child: FlatButton(
                    onPressed: isValid
                        ? () {
                            Navigator.pop(context);
                            widget.onOk(_email);
                          }
                        : null,
                    child: Text("Aceptar",
                        style: TextStyle(
                            color: isValid ? Colors.blue : Colors.black45))),
              )
            ],
          )
        ],
      ),
    );
  }
}
