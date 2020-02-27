import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_app_2/pages/chat_page.dart';
import 'package:my_flutter_app_2/pages/page_home_tabs/history_tab.dart';
import 'package:my_flutter_app_2/pages/page_home_tabs/home_tab.dart';
import 'package:my_flutter_app_2/pages/page_home_tabs/more_tab.dart';
import 'package:my_flutter_app_2/pages/page_home_tabs/oferts_tab.dart';
import 'package:my_flutter_app_2/widgets/my_appbar.dart';
import 'package:my_flutter_app_2/widgets/my_btn.dart';
import 'package:my_flutter_app_2/widgets/my_page_view.dart';
import '../widgets/avatar.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/circle_container.dart';
import '../widgets/cronometer.dart';
import 'images_page.dart';
import 'post_page.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  final _menu = [
    BottomMenuItem(
        iconPath: 'assets/icons/home.svg', label: 'Inicio', content: HomeTab()),
    BottomMenuItem(
        iconPath: 'assets/icons/history.svg',
        label: 'Historial',
        content: HistoryTab()),
    BottomMenuItem(
        iconPath: 'assets/icons/shop.svg',
        label: 'Ofertas',
        content: OfertsTab()),
    BottomMenuItem(
        iconPath: 'assets/icons/menu.svg', label: 'Más', content: MoreTab()),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomMenu(
        currentPage: _currentPage,
        onChanged: (int newCurrentPage) {
          setState(() {
            _currentPage = newCurrentPage;
          });
        },
        items: _menu,
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              // appbar
              MyAppbar(
                leftIcon: 'https://image.flaticon.com/icons/svg/685/685662.svg',
                rightIcon:
                    'https://image.flaticon.com/icons/svg/126/126501.svg',
                onRightClick: () {
                  final route = MaterialPageRoute(
                      builder: (BuildContext _) => ChatPage(
                            username: "Darwin Morocho",
                          ));
                  Navigator.push(context, route);
                },
                onLeftClick: () {
                  Navigator.pushNamed(context, ImagesPage.routeName,
                      arguments:
                          ImagesPageArgs(username: "Darwin", isActive: true));
                },
              ),

              Expanded(
                  child: MyPageView(
                children: _menu.map<Widget>((item) => item.content).toList(),
                currentPage: _currentPage,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
