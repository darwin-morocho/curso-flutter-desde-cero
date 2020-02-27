import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  final int currentPage;
  final List<Widget> children;

  MyPageView({Key key, @required this.currentPage, @required this.children})
      : assert(currentPage != null && currentPage >= 0),
        assert(children != null && children.length >= 0),
        super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  List<int> _renderedPages = [0];

  @override
  void didUpdateWidget(MyPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_renderedPages.contains(widget.currentPage)) {
      setState(() {
        _renderedPages.add(widget.currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      children: List.generate(widget.children.length, (index) {
        return _renderedPages.contains(index)
            ? widget.children[index]
            : Container();
      }),
      index: widget.currentPage,
    );
  }
}
