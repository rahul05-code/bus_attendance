import 'package:flutter/material.dart';
import 'http_service.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> attendanceList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  void fetchAttendance() async {
    final result = await HttpService.getDailyAttendance();
    setState(() {
      attendanceList = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today's Attendance")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : attendanceList.isEmpty
          ? Center(child: Text("No attendance yet today."))
          : ListView.builder(
              itemCount: attendanceList.length,
              itemBuilder: (context, index) {
                final entry = attendanceList[index];
                return ListTile(
                  title: Text(entry['name']),
                  subtitle: Text(
                    "Stop: ${entry['stop']} — Time: ${entry['time']}",
                  ),
                );
              },
            ),
    );
  }
}
