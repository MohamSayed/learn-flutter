import 'package:flutter/material.dart';

class ViewValueScreen extends StatefulWidget {
  final String value;
  const ViewValueScreen({this.value});
  @override
  _ViewValueScreenState createState() => _ViewValueScreenState();
}

class _ViewValueScreenState extends State<ViewValueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submitted value page')),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Your submitted value is:",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              Divider(
                height: 20.0,
              ),
              Text(widget.value)
            ],
          ),
        ),
      ),
    );
  }
}
