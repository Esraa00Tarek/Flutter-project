import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/screens/Login.dart';

void main() {
  testWidgets('Login screen has email, password fields, and submit button', (WidgetTester tester) async {
    // Build the Login screen
    await tester.pumpWidget(const MaterialApp(home: Login()));

    // Verify the presence of key UI elements
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password fields
    expect(find.text('Submit'), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text('Register Now'), findsOneWidget);
  });
}
