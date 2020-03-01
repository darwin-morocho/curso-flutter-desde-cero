import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_flutter_app_2/pages/login_page.dart';
import 'package:my_flutter_app_2/utils/dialogs.dart';
import 'package:my_flutter_app_2/widgets/avatar.dart';
import 'package:my_flutter_app_2/widgets/left_right_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreTab extends StatefulWidget {
  @override
  _MoreTabState createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (_) => false);
  }

  _confirm() async {
    final isOk = await Dialogs.confirm(context,
        title: "ACCIÓN REQUERIDA",
        body: "Esta seguro de que desea salir de su cuenta?");
    print("isOk $isOk");
    if (isOk) {
      _logOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xfff8f8f8),
              padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Avatar(
                    size: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Bienvenido"),
                  Text(
                    "Darwin Morocho",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            LeftRightIconButton(
              leftIcon: 'assets/icons/email.svg',
              rightContent: Text(
                "darwin@test.com",
                style: TextStyle(color: Color(0xffaaaaaa)),
              ),
              label: 'Email',
              onPressed: _confirm,
            ),
            LeftRightIconButton(
              leftIcon: 'assets/icons/security.svg',
              rightContent: SvgPicture.asset(
                'assets/icons/right-arrow.svg',
                width: 20,
              ),
              label: 'Configuraciones de privacidad',
              onPressed: _confirm,
            ),
            LeftRightIconButton(
              leftIcon: 'assets/icons/bell.svg',
              rightContent: Text("ACTIVADO",
                  style:
                      TextStyle(color: Color(0xffaaaaaa), letterSpacing: 0.5)),
              label: 'Notificaciones Push',
              onPressed: _confirm,
            ),
            LeftRightIconButton(
              leftIcon: 'assets/icons/logout.svg',
              label: 'Cerrar Sesión',
              onPressed: _confirm,
            )
          ],
        ),
      ),
    );
  }
}
