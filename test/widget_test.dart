// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_application_2/main.dart'; // แก้ชื่อโปรเจกต์

// void main() {
//   testWidgets('Login screen test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(MyApp());

//     // Verify that Login screen appears.
//     expect(find.text('Login'), findsOneWidget);

//     // Enter email and password
//     await tester.enterText(find.byType(TextField).first, 'test@example.com');
//     await tester.enterText(find.byType(TextField).at(1), 'password123');

//     // Tap the Login button
//     await tester.tap(find.text('Login'));
//     await tester.pumpAndSettle(); // Wait for the navigation to complete

//     // Verify that we are on the Main screen
//     expect(find.text('Main Screen'), findsOneWidget);
//   });

//   testWidgets('Log out test', (WidgetTester tester) async {
//     // Build the app and go to main screen.
//     await tester.pumpWidget(MyApp());

//     // Simulate login
//     await tester.enterText(find.byType(TextField).first, 'test@example.com');
//     await tester.enterText(find.byType(TextField).at(1), 'password123');
//     await tester.tap(find.text('Login'));
//     await tester.pumpAndSettle();

//     // Verify Main screen appears
//     expect(find.text('Main Screen'), findsOneWidget);

//     // Tap the 'Log Out' button
//     await tester.tap(find.text('Log Out'));
//     await tester.pumpAndSettle();

//     // Verify that we are back on the Login screen
//     expect(find.text('Login'), findsOneWidget);
//   });
// }
