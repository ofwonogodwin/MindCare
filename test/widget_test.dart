import 'package:flutter_test/flutter_test.dart';

import 'package:mindcare/main.dart';

void main() {
  testWidgets('Splash appears then navigates to login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MindCareApp());

    expect(find.text('MindCare'), findsOneWidget);
    expect(find.text('Your Mind Matters'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
