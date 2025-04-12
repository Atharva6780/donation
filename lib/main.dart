import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Screens/aboutus.dart';
import 'Screens/auth/login.dart';
import 'Screens/auth/signup.dart';
import 'Screens/dashboard.dart';
import 'Screens/donate.dart';
import 'Screens/footer.dart';
import 'Screens/home.dart';
import 'Screens/map_page.dart';
import 'Screens/need_blood.dart';
import 'Screens/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAacEFMXaNXdjc3B9DwMixnYEg6xuzlt8A",
            authDomain: "donation-48ef4.firebaseapp.com",
            projectId: "donation-48ef4",
            storageBucket: "donation-48ef4.firebasestorage.app",
            messagingSenderId: "868727367115",
            appId: "1:868727367115:web:63c8e3659dbd22d6c5424e",
            measurementId: "G-PKLG50ZDJS"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const BloodDonationApp());
}

class BloodDonationApp extends StatelessWidget {
  const BloodDonationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: AuthWrapper(), // Check authentication status
      routes: {
        '/home': (context) => const Home(),
        '/aboutus': (context) => AboutUsPage(),
        '/dashboard': (context) => const Dashboard(uid: 'uid'),
        '/donate': (context) => DonatePage(),
        '/footer': (context) => const Footer(),
        '/map': (context) => const HospitalPage(),
        '/need_blood': (context) => NeedBloodPage(uid: 'uid'),
        '/profile': (context) => ProfilePage(uid: 'uid'),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}

// **AuthWrapper checks if the user is logged in**
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Dashboard(uid: 'uid'); // If user is logged in, show Dashboard
        } else {
          return LoginPage(); // Otherwise, show Login Page
        }
      },
    );
  }
}
