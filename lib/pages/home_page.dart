import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_app_2/blocs/pages/master_bloc/master_bloc.dart';
import 'package:my_flutter_app_2/blocs/pages/master_bloc/master_events.dart';
import 'package:my_flutter_app_2/blocs/pages/master_bloc/master_state.dart';
import 'package:my_flutter_app_2/pages/chat_page.dart';
import 'package:my_flutter_app_2/pages/home_page_tabs/history_tab.dart';
import 'package:my_flutter_app_2/pages/home_page_tabs/home_tab.dart';
import 'package:my_flutter_app_2/pages/home_page_tabs/more_tab.dart';
import 'package:my_flutter_app_2/pages/home_page_tabs/oferts_tab.dart';
import 'package:my_flutter_app_2/widgets/my_appbar.dart';
import 'package:my_flutter_app_2/widgets/my_page_view.dart';
import '../widgets/bottom_menu.dart';
import 'images_page.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _menu = [
    BottomMenuItem(
        iconPath: 'assets/icons/home.svg', label: 'Inicio', content: HomeTab()),
    BottomMenuItem(
        iconPath: 'assets/icons/history.svg',
        label: 'Historial',
        content: HistoryTab()),
    BottomMenuItem(
        iconPath: 'assets/icons/heart.svg',
        label: 'Favoritos',
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
    final bloc = BlocProvider.of<MasterBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BlocBuilder<MasterBloc, MasterState>(
        builder: (_, state) {
          return BottomMenu(
            currentPage: state.currentTab,
            onChanged: (int newCurrentPage) {
              bloc.add(MasterSetTab(newCurrentPage));
            },
            items: _menu,
          );
        },
        condition: (prevState, newState) =>
            prevState.currentTab != newState.currentTab,
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
                leftIcon: 'assets/icons/pick-image.svg',
                rightIcon: 'assets/icons/chat.svg',
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
                child: BlocBuilder<MasterBloc, MasterState>(
                    builder: (_, state) {
                      return MyPageView(
                        children:
                            _menu.map<Widget>((item) => item.content).toList(),
                        currentPage: state.currentTab,
                      );
                    },
                    condition: (prevState, newState) =>
                        prevState.currentTab != newState.currentTab),
              )
            ],
          ),
        ),
      ),
    );
  }
}
