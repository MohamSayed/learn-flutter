import 'package:flutter/widgets.dart';

class Api  {
  List<int> getData()  {
    return List.generate(1000, (index) => index).toList();
  }
}
