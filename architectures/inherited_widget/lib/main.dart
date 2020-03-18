import 'package:flutter/material.dart';
import 'dart:math';
import './my_example.dart';

void main() => runApp(MaterialApp(
      title: "Random Squares",
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<MyApp> {
  final Random _random = Random();
  Color color = Colors.amber;

  void onTap() {
    setState(() {
      print("Changing color");
      color = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextDouble(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColorState(
      color: color,
      onTap: onTap,
      child: BoxTree(),
    );
  }
}

class ColorState extends InheritedWidget {
  ColorState({
    Key key,
    this.color,
    this.onTap,
    Widget child,
  }) : super(key: key, child: child);

  final Color color;
  final Function onTap;

  @override
  bool updateShouldNotify(ColorState oldWidget) {
    return color != oldWidget.color;
  }

  static ColorState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ColorState);
  }
}

class ColorState2 extends InheritedWidget {
  ColorState2({
    Key key,
    this.color,
    this.onTap,
    Widget child,
  }) : super(key: key, child: child);

  final Color color;
  final Function onTap;

  @override
  bool updateShouldNotify(ColorState oldWidget) {
    return color != oldWidget.color;
  }

  static ColorState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ColorState);
  }
}

class BoxTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: <Widget>[
            Box(),
            Box2(),
          ],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorState = ColorState.of(context);
    return GestureDetector(
      onTap: colorState.onTap,
      // onVerticalDragUpdate: (d) => print('dragging vertical'),
      // onHorizontalDragUpdate: (d) => print('dragging horizontal'),
      child: Container(
        width: 50.0,
        height: 50.0,
        margin: EdgeInsets.only(left: 100.0),
        // access colors easily from the parent widget AppState
        //color: colorState.color,
        color: Colors.black,

      ),
    );
  }
}

class Box2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorState = ColorState.of(context);
    return GestureDetector(
      onTap: colorState.onTap,
      // onVerticalDragUpdate: (d) => print('dragging vertical'),
      // onHorizontalDragUpdate: (d) => print('dragging horizontal'),
      child: Container(
        width: 50.0,
        height: 50.0,
        margin: EdgeInsets.only(left: 100.0),
        // access colors easily from the parent widget AppState
        color: colorState.color,
      ),
    );
  }
}