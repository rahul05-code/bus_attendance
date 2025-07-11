import 'package:flutter/material.dart';
import 'http_service.dart';

class AttendancePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  AttendancePage({required this.userData});

  void markAttendance(BuildContext context) async {
    final result = await HttpService.markAttendance(
      userData['uid'],
      userData['name'],
      userData['phone'],
      userData['city'],
      userData['bus'],
      userData['stop'],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                infoRow("Name", userData['name']),
                infoRow("Phone", userData['phone']),
                infoRow("City", userData['city']),
                infoRow("Bus", userData['bus']),
                infoRow("Stop", userData['stop']),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: Icon(Icons.check),
                  label: Text("Mark Attendance"),
                  onPressed: () => markAttendance(context),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
