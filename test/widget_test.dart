import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:donation/main.dart';
import 'package:donation/Screens/dashboard.dart';

void main() {
  testWidgets('Blood Donation App launches Dashboard', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BloodDonationApp());

    // Verify that the Dashboard is shown
    expect(find.byType(Dashboard), findsOneWidget);

    // You can add more specific tests based on your Dashboard widget
    // For example, if there are specific texts or widgets in the Dashboard
    // expect(find.text('Welcome'), findsOneWidget);
  });
}