import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nrental/screen/article_details_screen.dart';
import 'package:nrental/screen/article_screen.dart';
import 'package:nrental/screen/booking_detail_screen.dart';
import 'package:nrental/screen/booking_screen.dart';
import 'package:nrental/screen/dashboard_screen.dart';
import 'package:nrental/screen/login_screen.dart';
import 'package:nrental/screen/profile_screen.dart';
import 'package:nrental/screen/register_screen.dart';
import 'package:nrental/screen/search_screen.dart';
import 'package:nrental/screen/vehicle_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Register User", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 234, 98, 7),
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/loginScreen': (context) => const LoginScreen(),
      },
      home: const RegisterScreen(),
    ));
    Finder username = find.byKey(const ValueKey('username'));
    await tester.enterText(username, 'kakajjj');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder password = find.byKey(const ValueKey('password'));
    await tester.enterText(password, 'kakajjj');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder email = find.byKey(const ValueKey('email'));
    await tester.enterText(email, 'user543@gmail.com');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder phone = find.byKey(const ValueKey('phone'));
    await tester.enterText(phone, '23423423');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder signUpBtn = find.byKey(const ValueKey('signUpBtn'));
    await tester.tap(signUpBtn);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('signInBtn')), findsOneWidget);
  });

  testWidgets("Login User", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 234, 98, 7),
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/dashboardScreen': (context) => const DashboardScreen(),
        // '/registerScreen': (context) => const RegisterScreen(),
      },
      home: const LoginScreen(),
    ));
    Finder username = find.byKey(const ValueKey('username'));
    await tester.enterText(username, 'kakashi11');
    Finder password = find.byKey(const ValueKey('password'));
    await tester.enterText(password, 'kakashi11');
    FocusManager.instance.primaryFocus?.unfocus();
    Finder signInBtn = find.byKey(const ValueKey('signInBtn'));
    // Finder btnSignUp = find.byKey(const ValueKey('signUpBtn'));
    await tester.tap(signInBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(CurvedNavigationBar), findsOneWidget);
  });

  testWidgets("Articles Get", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 234, 98, 7),
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/articleDetailsScreen': (context) => const ArticleDetailsScreen(),
      },
      home: const ArticleScreen(),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder readMoreBtn =
        find.byKey(const ValueKey('readMoreBtn Tesla is coming to Nepal'));
    await tester.tap(readMoreBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Tesla is coming to Nepal'), findsOneWidget);
  });
  testWidgets("Vehicles Get", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 234, 98, 7),
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/vehicleScreen': (context) => const VehicleScreen(),
      },
      home: const SearchScreen(),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder categoryBtn = find.byKey(const ValueKey('categoryBtn Bike'));
    await tester.tap(categoryBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder bookBtn = find.byKey(const ValueKey('bookBtn Yamaha MT-7'));
    await tester.tap(bookBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Yamaha MT-7'), findsOneWidget);
  });

  testWidgets("Profile Update", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 234, 98, 7),
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/profileScreen': (context) => const ProfileScreen(),
      },
      home: const ProfileScreen(),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder updateFormBtn = find.byKey(const ValueKey('updateFormBtn'));
    await tester.tap(updateFormBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder addressText = find.byKey(const ValueKey('addressText'));
    await tester.enterText(addressText, 'bhaktapur');
    FocusManager.instance.primaryFocus?.unfocus();
    Finder updateBtn = find.byKey(const ValueKey('updateBtn'));
    await tester.tap(updateBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('bhaktapur'), findsOneWidget);
  });

  testWidgets("Cancel Booking", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 234, 98, 7),
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/bookingDetailScreen': (context) => const BookingDetailScreen(),
        '/dashboardScreen': (context) => const DashboardScreen(),
      },
      home: const BookingScreen(),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 4));
    Finder viewDetailsBtn =
        find.byKey(const ValueKey('viewDetailsBtn Yamaha MT-7'));
    await tester.tap(viewDetailsBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    Finder cancelBookingBtn =
        find.byKey(const ValueKey('cancelBookingBtn'));
    await tester.tap(cancelBookingBtn);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    Finder yesBtn = find.byKey(const ValueKey('yesBtn'));
    await tester.tap(yesBtn);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(CurvedNavigationBar), findsOneWidget);
  });
}
