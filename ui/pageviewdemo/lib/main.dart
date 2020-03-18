import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int current_page = 0;
  final controller = PageController(
    initialPage: 0,
    
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: PageView(
        controller: controller,
        scrollDirection: Axis.vertical, // up & down
        children: <Widget>[
          Material(
            color: Colors.greenAccent,
            child: InkWell(
              
              child: Center(
                child: Text("First Page", style: TextStyle(fontSize: 50.0),)           
              ),
            ),
          ),
          Material(
            color: Colors.greenAccent,
            child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [             
                    new IconButton(
                      icon: Icon(Icons.arrow_upward),
                      onPressed: () => controller.jumpToPage(0)
                      ),
                    Center(
                                                     
                      child: Text("Second Page", style: TextStyle(fontSize: 50.0),)
                  ),           
                ],
              ),           
            ),   
          )
        ],
      )
    );

  }
  setPage(int id) {
    //setState((){ current_page = id;});
    controller.previousPage();
    print("current page $current_page");
  }
}