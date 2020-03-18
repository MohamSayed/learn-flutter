import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignPage(),
    );
  }
}

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  List<Path> _paths = <Path>[];
  List<Path> _erasePaths = <Path>[];

  ByteData imgBytes;
  String _msg = '';
  bool _loading = false;
  bool eraser = false;

  Future<ui.Image> get rendered {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    Signature painter = Signature(paths: _paths);
    var size = context.size;
    painter.paint(canvas, size);
    return recorder
        .endRecording()
        .toImage(size.width.floor(), size.height.floor());
  }

  @override
  void initState() {
    super.initState();
  }

  _showImage() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTheme(
                  child: RaisedButton(
                    onPressed: () async {
                      String b64image =
                          base64.encode(imgBytes.buffer.asUint8List());
                    },
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 3,
                child: imgBytes != null
                    ? Image.memory(
                        new Uint8List.view(imgBytes.buffer),
                      )
                    : new Container(
                        height: 0,
                      ),
              ),
            ],
          );
        });
  }

  Color color;
  @override
  Widget build(BuildContext context) {
    if (eraser) {
      color = Colors.white;
    } else {
      color = Colors.black;
    }
    return Scaffold(
      appBar: AppBar(
        bottom: _msg != ''
            ? PreferredSize(
                preferredSize: Size(0, 20),
                child: Column(
                  children: <Widget>[
                    _loading ? CircularProgressIndicator() : Container(),
                    _msg != ''
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 7),
                            child: Text(
                              _msg,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))
                        : Container(),
                  ],
                ),
              )
            : null,
        title: Text('SignatureDemo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _paths.clear(),
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.save_alt),
            color: Colors.white,
            onPressed: () async {
              final img = await rendered;
              final pngBytes =
                  await img.toByteData(format: ui.ImageByteFormat.png);

              setState(() {
                imgBytes = pngBytes;
                debugPrint("onPressed " +
                    base64.encode(imgBytes.buffer.asUint8List()));
              });

              _showImage();
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              if (eraser) {
                eraser = false;
              } else {
                eraser = true;
              }
            },
          ),
        ],
      ),
      body: Container(
        child: GestureDetector(
          onPanStart: (DragStartDetails details) {
            setState(() {
              RenderBox box = context.findRenderObject();
              Offset _localPosition = box.globalToLocal(details.globalPosition);
              _localPosition = _localPosition.translate(
                  0.0, -(AppBar().preferredSize.height + 20));
              Path path = new Path();
              if (!eraser) {
                path.moveTo(_localPosition.dx, _localPosition.dy);
                _paths = List.from(_paths)..add(new Path.from(path));
              } else {
                _erasePaths = List.from(_erasePaths)..add(new Path.from(path));
              }
            });
          },
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox box = context.findRenderObject();
              Offset _localPosition = box.globalToLocal(details.globalPosition);
              _localPosition = _localPosition.translate(
                  0.0, -(AppBar().preferredSize.height + 20));
              Path path = _paths.last;
              path.lineTo(_localPosition.dx, _localPosition.dy);
            });
          },
          child: CustomPaint(
            painter: Signature(paths: _paths + _erasePaths, color: color),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class Signature extends CustomPainter {
  List<Path> paths = new List<Path>();
  Color color;
  Signature({this.paths, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    for (Path p in paths) {
      canvas.drawPath(p, paint);
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => true;
}
