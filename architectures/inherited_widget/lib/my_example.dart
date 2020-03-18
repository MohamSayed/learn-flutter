import 'package:flutter/material.dart';
import 'on_file.dart';
import 'dart:math';

class Example2 extends StatefulWidget {
  _Example2State createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  String text = "initial text";
  void onTap() {
    print("Changing text");
    setState(() {
      text = Random().nextInt(200).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyInheritedWidgetState(onTap: onTap, text: text, child: BoxText()),
    );
  }
}

class MyInheritedWidgetState extends InheritedWidget {
  MyInheritedWidgetState({
    Key key,
    this.text,
    this.onTap,
    Widget child,
  }) : super(key: key, child: child);

  final String text;
  final Function onTap;

  @override
  bool updateShouldNotify(MyInheritedWidgetState oldWidget) {
    return text != oldWidget.text;
  }

  static MyInheritedWidgetState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyInheritedWidgetState);
  }
}

class BoxText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BoxTextBranch(),
    );
  }
}

