import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/widgets/my_appbar.dart';
import '../utils/fake_list.dart';

class PostsPage extends StatefulWidget {
  static final routeName = 'posts';

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<String> _data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                onLeftClick: () => Navigator.pop(context),
                onRightClick: () {
                  _data.add("item ${DateTime.now()}");
                  _data.insert(_data.length > 0 ? _data.length - 1 : 0,
                      "item before ${DateTime.now()}");

                  setState(() {});
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int position) {
                    final String item = _data[position];
                    return ListTile(
                      title: Text(item),
                      subtitle: Text("subtitulo"),
                      leading: Icon(Icons.watch),
                      onTap: () {},
                      onLongPress: () {
                        setState(() {
                          _data.removeAt(position);
                        });
                      },
                    );
                  },
                  itemCount: _data.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
