import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/transformers.dart';
import 'dart:async';

enum Actions { Increment }

Stream counterReducer(Stream state, dynamic action) {
  if (action == Actions.Increment) {
    var obs = Observable(state);
    return obs.asyncMap((value) => value + 1);
  }
  return state;
}

void main() {
  Stream myStream = Stream.fromIterable([1]).asBroadcastStream();
  final store = new Store<Stream>(counterReducer, initialState: myStream);

  runApp(new FlutterReduxApp(
    title: 'Flutter Redux Demo',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<Stream> store;
  final String title;

  FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<Stream>(
      store: store,
      child: new MaterialApp(
        theme: new ThemeData.dark(),
        title: title,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text(title),
          ),
          body: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Text(
                  'You have pushed the button this many times:',
                ),
                new StoreConnector<Stream, Stream>(
                  converter: (store) => store.state,
                  builder: (context, stream) {
                    return StreamBuilder(
                      stream: stream,
                      builder: (context, snapshot) => new Text(
                            "stream value: ${snapshot.data}",
                            style: Theme.of(context).textTheme.display1,
                          ),
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButton: new StoreConnector<Stream, VoidCallback>(
            converter: (store) {
              return () => store.dispatch(Actions.Increment);
            },
            builder: (context, callback) {
              return new FloatingActionButton(
                onPressed: callback,
                tooltip: 'Increment',
                child: new Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}
