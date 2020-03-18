import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _counterBloc = CounterBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _counterBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: _counterBloc, child: new CounterWidget());
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocBuilder(
            bloc: BlocProvider.of<CounterBloc>(context),
            builder: (context, state) => GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                          state >= 1 ? state : 0,
                          (index) => Card(
                                  child: Center(
                                      child: Text(
                                "$index",
                                style: TextStyle(fontSize: 20.0),
                              )))).toList() ??
                      Card(
                          child: Center(
                              child: Text(
                        "empty",
                        style: TextStyle(fontSize: 20.0),
                      ))),
                )),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          FloatingActionButton(
            onPressed: BlocProvider.of<CounterBloc>(context).increment,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: BlocProvider.of<CounterBloc>(context).decrement,
            child: Icon(Icons.remove),
          ),
        ]),
      ),
    );
  }
}

abstract class BaseEvent {}

class Increment extends BaseEvent {}

class Decrement extends BaseEvent {}

class CounterBloc extends Bloc<BaseEvent, int> {
  void increment() {
    dispatch(Increment());
  }

  void decrement() {
    dispatch(Decrement());
  }

  @override
  // TODO: implement initialState
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int currentState, BaseEvent event) async* {
    // TODO: implement mapEventToState
    if (event is Increment) {
      yield currentState + 1;
    } else if (event is Decrement) {
      yield currentState - 1;
    }
  }
}
