import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc1.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: AppBloc3(),
      child: MaterialApp(
        title: 'Yo Sleep',
        home: Bloc3(),
        initialRoute: 'main',
        routes: {
          'page2': (context) => Page3(),
        },
      ),
    );
  }
}

class Bloc3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc3 = BlocProvider.of<AppBloc3>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 3"),
      ),
      body: StreamBuilder(
        stream: appBloc3.textStream,
        //initialData: appBloc3.initialState.toString(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text(snapshot.data[index].toString()),
                  onTap: () {},
                  dense: true,
                ),
          );
        },
      ),
    );
  }
}

class AppBloc3 extends Bloc {
  StreamController _text = StreamController<List<String>>();
  Stream<List<String>> get textStream {
    _text.add(List.generate(10, (index) => "Index: $index"));
    return _text.stream..asBroadcastStream();
  }

  StreamSink<String> get textSink => _text.sink;

  void dispose() {
    _text.close();
  }

  void removeElement(int index) {
    dispatch(IncreaseEvent());
  }

  @override
  // TODO: implement initialState
  get initialState => 'null';

  @override
  Stream mapEventToState(currentState, dynamic event) {
    if (event is RemoveEvent) {
      _text.stream.
    }
  }
}

class BaseEvent {}

class RemoveEvent extends BaseEvent {}
