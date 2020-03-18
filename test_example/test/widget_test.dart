// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_example/main.dart';

void main() {
  testWidgets('sumbittig testing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // NOTE: finding by id
    Finder textField = find.byKey(Key("textfield"));
    await tester.enterText(textField, "my text");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    Finder submitButton = find.byKey(Key("button"));
    await tester.tap(submitButton);
    await tester.pump();
    Finder submittedValueText = find.text("my text");
    await tester.pump();
    tester.any(submittedValueText);
    // Expecting 2 widgets
    expect(submittedValueText.evaluate().length, 2);
  });
}
