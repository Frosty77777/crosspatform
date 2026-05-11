// Chapter 18 — Top-level smoke test.
//
// The auto-generated widget_test.dart from `flutter create` tried to
// boot the entire app, which now requires Firebase initialisation and
// therefore cannot run inside a unit-test sandbox.
//
// We keep a minimal smoke test here so `flutter test` always has at
// least one trivially-passing case, and we point readers to the more
// focused suites under test/unit/ and test/widget/.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test harness is wired up', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Text('hello tests'))),
    );

    expect(find.text('hello tests'), findsOneWidget);
  });
}
