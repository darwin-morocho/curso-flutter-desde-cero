import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/widgets/my_appbar.dart';

class ChatPage extends StatefulWidget {
  final String username;

  const ChatPage({Key key, @required this.username})
      : assert(username != null),
        super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              MyAppbar(
                leftIcon: 'https://image.flaticon.com/icons/svg/860/860790.svg',
                rightIcon:
                    'https://image.flaticon.com/icons/svg/126/126501.svg',
                onRightClick: () {},
                onLeftClick: () => Navigator.pop(context),
              ),
              Expanded(child: Center(child: Text(widget.username)))
            ],
          ),
        ),
      ),
    );
  }
}
