// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:user_app/main.dart';

void main() {
  testWidgets('bottom navigation switches between app pages', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Good morning, Alex'), findsOneWidget);
    expect(find.text('Explore categories'), findsOneWidget);

    await tester.tap(find.text('Orders'));
    await tester.pump();
    expect(find.text('Your orders'), findsOneWidget);
    expect(find.text('#10482'), findsOneWidget);

    await tester.tap(find.text('Search'));
    await tester.pump();
    expect(find.text('Find something good'), findsOneWidget);
    expect(find.text('Suggested for you'), findsOneWidget);
  });
}
