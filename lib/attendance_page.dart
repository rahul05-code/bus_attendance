import 'package:flutter/material.dart';
import 'http_service.dart';

class AttendancePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  AttendancePage({required this.userData});

  @override
  Widget build(BuildContext context) {
    final name = userData['name'];
    final phone = userData['phone'];
    final city = userData['city'];
    final stop = userData['stop'];
    final uid = userData['uid'];

    return Scaffold(
      appBar: AppBar(title: Text("Welcome, $name")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("City: $city", style: TextStyle(fontSize: 18)),
            Text("Stop: $stop", style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text("Mark Attendance"),
              onPressed: () async {
                final result = await HttpService.markAttendance(
                  uid,
                  name,
                  phone,
                  city,
                  stop,
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(result)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
