import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_project/app/app.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await ObjectBoxConfig.initOB(path: "/hello");
  testWidgets('Testing text All display 2 widget in dashboard',
      (WidgetTester tester) async {
    // // Build our app and trigger a frame.
    await tester.pumpWidget(Application());
    //

    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.

    //await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //

    // await Future.delayed(const Duration(seconds: 1));
    expect(find.byIcon(Icons.add), findsOneWidget);
    // expect(find.text('1'), findsOneWidget);
  });
}
