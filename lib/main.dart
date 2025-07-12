import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';
import 'login_page.dart';
import 'attendance_page.dart';
//import 'admin_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase if needed
  runApp(BusAttendanceApp());
}

class BusAttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus Attendance System',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/attendance': (context) => AttendancePage(userData: {}),
        //'/admin': (context) => AdminPage(),
      },
    );
  }
}
