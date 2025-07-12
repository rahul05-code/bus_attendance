import 'package:flutter/material.dart';
import 'firebase_service.dart';

class AdminViewdata extends StatefulWidget {
  @override
  _AdminAttendanceReportPageState createState() => _AdminAttendanceReportPageState();
}

class _AdminAttendanceReportPageState extends State<AdminViewdata> {
  List<Map<String, dynamic>> records = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  void fetchAttendance() async {
    final data = await FirebaseService.getAllAttendance(selectedDate);
    setState(() => records = data);
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      fetchAttendance();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Report"),
        actions: [
          IconButton(onPressed: _pickDate, icon: Icon(Icons.calendar_today))
        ],
      ),
      body: records.isEmpty
          ? Center(child: Text("No attendance found"))
          : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final r = records[index];
                return ListTile(
                  title: Text(r['name']),
                  subtitle: Text("${r['city']} • ${r['bus']} • ${r['stop']}"),
                  trailing: Text(r['time']),
                );
              },
            ),
    );
  }
}
