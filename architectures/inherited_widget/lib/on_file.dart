import 'package:flutter/material.dart';
import 'my_example.dart';

class BoxTextBranch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textState = MyInheritedWidgetState.of(context);

    return GestureDetector(
      onTap: textState.onTap,
      child: Center(
        child: Text(textState.text),
      ),
    );
  }
}
