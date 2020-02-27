import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/widgets/avatar.dart';
import 'package:my_flutter_app_2/widgets/cronometer.dart';
import 'package:my_flutter_app_2/widgets/my_btn.dart';

import '../post_page.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool _isEnabled = false;
  double _fontSize = 20;

  @override
  Widget build(BuildContext context) {
    print("inicio");
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(
        builder: (context, contraints) {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Color(0xfff8f8f8),
                    height: contraints.maxHeight * 0.5,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Avatar(
                          size: contraints.maxHeight * 0.25,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Bienvenido"),
                        Text(
                          "Darwin Morocho",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: 10),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return Container(
                          width: 120,
                          height: 120,
                          margin: EdgeInsets.all(5),
                          color: Colors.black12,
                        );
                      },
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return Container(
                          width: 120,
                          height: 120,
                          margin: EdgeInsets.all(5),
                          color: Colors.black12,
                        );
                      },
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 120,
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        return Container(
                          width: 120,
                          height: 120,
                          margin: EdgeInsets.all(5),
                          color: Colors.black12,
                        );
                      },
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                    ),
                  )
                  // _isEnabled == true
                  //     ? Cronometer(
                  //         initTime: 990,
                  //         fontSize: _fontSize,
                  //       )
                  //     : Container(),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // CupertinoButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _isEnabled = !_isEnabled;
                  //     });
                  //   },
                  //   color: Colors.blue,
                  //   child: Text("enabled: $_isEnabled"),
                  // ),
                  // // SizedBox(
                  //   height: 20,
                  // ),
                  // CupertinoButton(
                  //   onPressed: () {},
                  //   color: Colors.green,
                  //   child: Text("Go to Chat"),
                  // ),
                  // MyBtn(
                  //   label: "My Posts",
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, PostsPage.routeName);
                  //   },
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
