import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/transformers.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () {
              i = 0;
              setState(() {});
              print("reset");
            },
            child: Text("BUTTON"),
          ),
          Container(
              child: Center(
                  child: StreamBuilder<int>(
            initialData: 0,
            stream: _myStream(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Select lot');
                case ConnectionState.waiting:
                  return Text('Awaiting bids...');
                case ConnectionState.active:
                  return Text('${snapshot.data}');
                case ConnectionState.done:
                  return Text('${snapshot.data}');
              }
              return null;
            },
          )))
        ],
      )),
    );
  }

  Stream<int> _myStream() async* {
    for (i = 0; i < 1000; i++) {
      await Future.delayed(Duration(milliseconds: 10));
      yield i + 1;
    }

  }
}
