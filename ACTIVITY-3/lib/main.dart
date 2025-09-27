import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/login_page.dart';
import 'pages/registration_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/ordering_page.dart';
import 'pages/reservation_page.dart';
import 'pages/tracking_page.dart';
import 'pages/payment_page.dart';
import 'pages/feedback_form.dart'; // Keeping feedback form

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicketMaster Live',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/dashboard': (context) => const DashboardPage(role: 'User'),
        '/ordering': (context) => const OrderingPage(),
        '/reservation': (context) => const ReservationPage(),
        '/tracking': (context) => const TrackingPage(),
        '/payment': (context) => const PaymentPage(),
        '/feedback': (context) => const FeedbackForm(), // Keeping feedback form
      },
      onGenerateRoute: (settings) {
        print('Generating route for ${settings.name}');
        if (settings.name == '/splash')
          return MaterialPageRoute(builder: (context) => const SplashScreen());
        return null;
      },
    );
  }
}
