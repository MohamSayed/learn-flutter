import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animation = Tween(begin: 10.0, end: 50.0).animate(_animationController)
      // updating the state
      ..addListener(() => setState(() {}));

    //_animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Text(
                  "Hello World!",
                  style: TextStyle(fontSize: _animation.value),
                ),
              ),
              Flexible(
               
                flex: 2,
                child: FlatButton(
                  onPressed: () {
                    _animationController.reset();
                    _animationController.forward();
                  },
                  color: Colors.redAccent,
                  child: Icon(Icons.refresh),
                ),
              )
            ])),
      )),
    );
  }
}
