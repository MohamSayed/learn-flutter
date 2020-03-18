import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            body: Center(
                child: StreamBuilder(
      stream: Stream.fromIterable(List.generate(10000, (int i) => i + 1)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Select lot');
          case ConnectionState.waiting:
            return Text('Awaiting bids...');
          case ConnectionState.active:
            return Text('active');
          case ConnectionState.done:
            return Text(snapshot.data.toString());
        }
        return null;
      },
    ))));
  }
}
