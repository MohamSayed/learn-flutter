import 'package:flutter/material.dart';
import 'myappbar.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          backgroundColor: Colors.white,
          title: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Search'),
          ),
          leading: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          actions: <Widget>[
            Icon(
              Icons.keyboard_voice,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
