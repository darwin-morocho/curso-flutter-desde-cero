import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/pages/home_page.dart';
import 'package:my_flutter_app_2/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((_) {
      print("ir a home");
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          radius: 15,
        ),
      ),
    );
  }
}
