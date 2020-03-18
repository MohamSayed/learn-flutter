import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


abstract class CounterEvent {}

class IncrementCounter extends CounterEvent {
  @override
  String toString() => 'IncrementCounter';
}

class DecrementCounter extends CounterEvent {
  @override
  String toString() => 'DecrementCounter';
}

class CounterBloc extends Bloc<CounterEvent, int> {
  void increment() {
    dispatch(IncrementCounter());
  }

  void decrement() {
    dispatch(DecrementCounter());
  }

  @override
  int get initialState => 0;

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print(transition.toString());
  }

  @override
  Stream<int> mapEventToState(int state, CounterEvent event) async* {
    if (event is IncrementCounter) {
      /// Simulating Network Latency etc...
      await Future<void>.delayed(Duration(seconds: 1));
      yield state + 1;
    }
    if (event is DecrementCounter) {
      /// Simulating Network Latency etc...
      await Future<void>.delayed(Duration(milliseconds: 500));
      yield state - 1;
    }
  }
}

final counterBloc = CounterBloc();

void main() async {
  // Increment Phase
  counterBloc.dispatch(IncrementCounter());

  // Decrement Phase
  counterBloc.dispatch(DecrementCounter());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            RaisedButton(
              child: Text("Increment +"),
              onPressed: () => counterBloc.dispatch(IncrementCounter()),
            ),
            RaisedButton(
              child: Text("Decrement -"),
              onPressed: () => counterBloc.dispatch(DecrementCounter()),
            ),
          ])),
    ));
  }
}
