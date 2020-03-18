// framework
import 'package:flutter/material.dart';

// packages
import 'package:scoped_model/scoped_model.dart';

// local files
import 'package:scoped_model_demo/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(), child: MaterialApp(home: HomePage()));
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
            ),
            ScopedModelDescendant<AppModel>(
              builder: (context, child, model) => Center(
                    child: RaisedButton(
                      child: Text("Add"),
                      color: Colors.greenAccent,
                      onPressed: () {
                        model.addItem(Item(_controller.text.toString()));
                      },
                    ),
                  ),
            ),
            RaisedButton(
              child: Text("display Page"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DisplayPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}

class DisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) {
              return Container(
                child: ListView.builder(
                  itemCount: model.items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onLongPress: () {
                          model.deleteItem(model.items[index]);
                        },
                        child: Text(model.items[index].name));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
