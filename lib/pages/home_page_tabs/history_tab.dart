import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    print("historial");
    return AspectRatio(
      aspectRatio: 7/4,
      child: Container(
        color: Colors.red,
        child: Image.network('https://as.com/meristation/imagenes/2019/12/12/avances/1576175321_723620_1576327909_noticia_normal.jpg'),
      ),
    );
  }
}
