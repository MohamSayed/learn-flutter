import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_test1/mulit_bloc/bloc2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: AppBloc(),
      child: MaterialApp(
        title: 'Yo Sleep',
        home: MainPage(),
        initialRoute: 'main',
        routes: {
          'main': (context) => MainPage(),
        },
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
      ),
      body: Center(
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            StreamBuilder(
              stream: appBloc.textStream,
              initialData: appBloc.initialState.toString(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                return Text(snapshot.hasData ? snapshot.data : 'loading');
              },
            ),
            FlatButton(
              child: Text("show"),
              onPressed: () => appBloc.showString(),
            ),
            FlatButton(
                child: Text("Second Bloc >"),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page2()))),
          ]),
        ),
      ),
    );
  }
}

class AppBloc extends Bloc {
  StreamController _text = StreamController<String>();
  Stream<String> get textStream => _text.stream..asBroadcastStream();
  StreamSink<String> get textSink => _text.sink;

  void dispose() {
    _text.close();
  }

  void showString() {
    dispatch(IncreaseEvent());
  }

  @override
  // TODO: implement initialState
  get initialState => 'null';

  @override
  Stream mapEventToState(currentState, event) {
    if (event is IncreaseEvent) {
      _text.add("event");
    }
  }
}

class BaseEvent {}

class IncreaseEvent extends BaseEvent {}
