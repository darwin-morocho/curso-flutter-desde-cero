import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/avatar.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/circle_container.dart';
import '../widgets/cronometer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomMenu(
        items: [
          BottomMenuItem(iconPath: 'assets/icons/home.svg', label: 'Inicio'),
          BottomMenuItem(
              iconPath: 'assets/icons/history.svg', label: 'Historial'),
          BottomMenuItem(iconPath: 'assets/icons/shop.svg', label: 'Ofertas'),
          BottomMenuItem(iconPath: 'assets/icons/menu.svg', label: 'Más'),
        ],
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Avatar(),
              SizedBox(
                height: 20,
              ),
              Text("Bienvenido"),
              Text(
                "Darwin Morocho",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _isEnabled == true
                  ? Cronometer(
                      initTime: 990,
                      fontSize: 40,
                    )
                  : Container(),
              SizedBox(
                height: 30,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {
                    _isEnabled = !_isEnabled;
                  });
                },
                color: Colors.blue,
                child: Text("enabled: $_isEnabled"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
