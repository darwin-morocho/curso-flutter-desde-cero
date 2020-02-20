import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app_2/widgets/circle_container.dart';

class Cronometer extends StatefulWidget {
  final double initTime, fontSize;

  const Cronometer({Key key, this.initTime = 0, this.fontSize = 20})
      : super(key: key);

  @override
  CronometerState createState() => CronometerState();
}

class CronometerState extends State<Cronometer> {
  double _time;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    print("initState");
    _time = widget.initTime;
  }

  @override
  void dispose() {
    // cancel timer
    print("dispose");
    _stop();
    super.dispose();
  }

  void _start() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer _) {
      setState(() {
        _time += 1;
      });
    });
  }

  void _stop() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            _time.toString(),
            style: TextStyle(fontSize: widget.fontSize),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(
                child: CircleContainer(child: Icon(Icons.play_arrow), size: 55),
                onPressed: _start,
              ),
              CupertinoButton(
                child: CircleContainer(child: Icon(Icons.stop), size: 55),
                onPressed: _stop,
              )
            ],
          )
        ],
      ),
    );
  }
}
