import 'package:flutter/material.dart';
import './my_table.dart';

void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
            child: MyTable()
          ),
      ),
    );
  }
}