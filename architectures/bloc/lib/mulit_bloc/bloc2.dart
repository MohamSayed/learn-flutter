import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc3.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: AppBloc2(),
      child: MaterialApp(
        title: 'Yo Sleep',
        home: Bloc2(),
        initialRoute: 'main',
        routes: {
          'page2': (context) => Page2(),
        },
      ),
    );
  }
}

class Bloc2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc2 = BlocProvider.of<AppBloc2>(context);
    return Scaffold(
         appBar: AppBar(
        title: Text("Page 2"),
      ),
      body: Center(
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            StreamBuilder(
              stream: appBloc2.textStream,
              initialData: appBloc2.initialState.toString(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                return Text(snapshot.hasData ? snapshot.data : 'loading');
              },
            ),
            FlatButton(
              child: Text("show"),
              onPressed: () => appBloc2.showString(),
            ),
            FlatButton(
                child: Text("Third Bloc >>"),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page3()))),
          ]),
        ),
      ),
    );
  }
}

class AppBloc2 extends Bloc {
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
