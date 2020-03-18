/* 
  * [@training @flutter @examples @willpopscope @dialog @exit.dialog @exiting @catch.exit]
  * This example shows how to stop the app from exiting accidently.
  * Also, show how to catch pop event
  * Relation:
    * [Navigator]
*/


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MaterialApp cannot be subwidget of WillPopScope
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //
    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: Center(child: Text("Centered Text")),
        ),
      ),
      onWillPop: () async {
        // you can show alert before exiting the app
        print("Poping up last screen");

        // showDialog method return [Future<pop value>]
        // then we await for the value to complete
        bool result = await showDialog(
            context: context, builder: (context) => ExitDialog());

        // if user choose 'Ok' then exit the app
        if (result) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
        // or
        // exiting the app and sending signal 0 to the os
        // exit(0) // from `io` package
        // but SystemChannels... is preferable
      },
    );
  }
}

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Exit the app"),
      contentPadding: EdgeInsets.all(10.0),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          // exiting dialog and return false result
          // pop value
          onPressed: () => Navigator.pop(context, false),
        ),
        FlatButton(
          child: Text("Ok"),
          // exiting dialog and return true result
          // pop value
          onPressed: () => Navigator.pop(context, true),
        )
      ],
    );
  }
}
