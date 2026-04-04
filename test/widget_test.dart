import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mindcare/main.dart';

void main() {
  testWidgets('Splash appears then navigates to welcome', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({'is_first_launch': true});
    await tester.pumpWidget(const MindCareApp());

    expect(find.text('MindCare'), findsOneWidget);
    expect(find.text('Your Safe Space for Mental Wellness'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Welcome to MindCare'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
