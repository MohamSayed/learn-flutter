import 'package:flutter/material.dart';
import 'package:image_editing_sketch/app_model.dart';
import 'package:image_editing_sketch/sketcher.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppModel model;
  @override
  void initState() {
    model = AppModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Container sketchArea = Container(
      height: 500,
      width: 300,
      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      color: Colors.blueGrey[50],
      child: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => CustomPaint(
              foregroundPainter: Sketcher(
                points: model.points,
              ),
              child: Container(
                height: 500,
                width: 300,
                child: Image.asset("assets/woman.jpg"),
              ),

              //painter: Sketcher(points),
            ),
      ),
    );

    return ScopedModel<AppModel>(
      model: model,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Sketcher'),
          ),
          // detecting user gestures
          body: GestureDetector(
            // while moving
            onPanUpdate: (DragUpdateDetails details) async {
              // note: any function or code the freeze the execution of this function
              // might cause lines to connect
              print('Start drawing in position: ${details.globalPosition}');
              RenderBox box = context.findRenderObject();
              Offset point = box.globalToLocal(details.globalPosition);
              point = point.translate(0.0, -(AppBar().preferredSize.height));
              Future.delayed(Duration(milliseconds: 10));
              model.setPoints(List.from(model.points)..add(point));
            },
            onPanEnd: (DragEndDetails details) {
              print('End drawing in position: $details');

              model.addPoints(null);
            },
            // onTapUp: (details) {
            //   // note: any function or code the freeze the execution of this function
            //   // might cause lines to connect
            //   print('Start drawing in position: ${details.globalPosition}');
            //   RenderBox box = context.findRenderObject();
            //   Offset point = box.globalToLocal(details.globalPosition);
            //   point = point.translate(0.0, -(AppBar().preferredSize.height));

            //   model.setPoints(List.from(model.points)..add(point));
            // },
            // Connecting from the previously tapped point to the currently
            // pressed point *--------------*
            // onTapDown: (details) {
            //   print('Drawing in location: ${details.globalPosition}');
            //   RenderBox box = context.findRenderObject();
            //   Offset point = box.globalToLocal(details.globalPosition);
            //   point =
            //       point.translate(0.0, -(AppBar().preferredSize.height) - 25);
            //   model.setPoints(List.from(model.points)..add(point));
            // },
            child: Column(children: [
              sketchArea,
              Container(
                child: ScopedModelDescendant<AppModel>(
                  builder: (context, child, model) => Slider(
                        value: model.strokeSizeSliderValue,
                        min: 0.0,
                        max: 20.0,
                        onChanged: (value) {
                          model.setSlider(value);
                        },
                      ),
                ),
              )
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'clear Screen',
            backgroundColor: Colors.red,
            child: Icon(Icons.settings_backup_restore),
            onPressed: () {
              model.clearPoints();
            },
          ),
        ),
      ),
    );
  }
}
