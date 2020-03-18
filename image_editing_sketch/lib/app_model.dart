import 'dart:ui';

import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  List<dynamic> points = <dynamic>[];
  void addPoints(dynamic _points) {
    points.add(_points);
    notifyListeners();
  }

  void setPoints(List<dynamic> _points) {
    points = _points;
    notifyListeners();
  }

  void clearPoints() {
    points.clear();
    notifyListeners();
  }

  double strokeSizeSliderValue = 2;
  void setSlider(double value) {
    strokeSizeSliderValue = value;
    notifyListeners();
  }
}
