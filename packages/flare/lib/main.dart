import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
      child: Center(
        child: FlareActor(
          "assets/rect.flr",
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: 'main',
        ),
      ),
    )));
  }
}
