import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app_2/pages/images_page.dart';
import 'package:my_flutter_app_2/pages/login_page.dart';
import 'package:my_flutter_app_2/pages/post_page.dart';
import 'package:my_flutter_app_2/pages/splash_page.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();
      },
      child: MaterialApp(
        home: SplashPage(),
        routes: {
          ImagesPage.routeName: (BuildContext context) => ImagesPage(),
          HomePage.routeName: (_) => HomePage(),
          PostsPage.routeName: (_) => PostsPage(),
          LoginPage.routeName: (_) => LoginPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
      ),
    );
  }
}
