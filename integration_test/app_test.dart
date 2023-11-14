import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fake_cheers_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final name = find.byKey(const Key('text-field-name'));
  final yearBorn = find.byKey(const Key('text-field-year-born'));
  final submit = find.byKey(const Key('button-submit'));
  final reset = find.byKey(const Key('button-reset'));
  final luckyButton = find.byKey(const Key('button-lucky-person'));
  final luckyText = find.byKey(const Key('lucky-person-text'));
  final cheerUpText = find.byKey(const Key('text-cheer-up'));

  final error1 = find.text("Please enter your name!!");
  final error2 = find.text("Cmon don't shy :)");
  final error3 = find.text("Pick one!");

  testWidgets('Verify cheer up text is visible', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(name, "John");
    await tester.pump();

    await tester.enterText(yearBorn, "2000");
    await tester.pump();

    final mood = find.byType(CheckboxListTile).first;
    await tester.tap(mood);
    await tester.pump();

    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(cheerUpText, findsOneWidget);
  });

  testWidgets('Verify lucky person response is visible',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(luckyButton);
    await tester.pumpAndSettle();

    expect(luckyText, findsOneWidget);
  });

  testWidgets('Verify reset is working', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(error1, findsOneWidget);
    expect(error2, findsOneWidget);
    expect(error3, findsOneWidget);

    await tester.tap(reset);
    await tester.pumpAndSettle();

    expect(error1, findsNothing);
    expect(error2, findsNothing);
    expect(error3, findsNothing);
  });
}
