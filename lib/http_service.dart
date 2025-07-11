import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  // Replace these URLs with your actual deployed script links
  static const String userSheetUrl =
      "https://script.google.com/macros/s/AKfycbytkHiI4Pp7AQsHHcTnRk9Gf1rJFpaYyJbCyslHlOU9Ih2cq11XJWPZ9yDwvzI0rI6kNA/exec";
  static const String attendanceSheetUrl =
      "https://script.google.com/macros/s/AKfycbwx30_sVKBffmik_uftEmYFiuQuHrRSobV1Qb4MbvLLhFbPNUONzxBo8yMAEglOSmqWWA/exec";

  // ---------------------- USER OPERATIONS ----------------------

  static Future<String> registerUser(
    String name,
    String phone,
    String city,
    String bus,
    String stop,
    String password,
  ) async {
    final url = Uri.parse(
      "$userSheetUrl?action=register"
      "&name=${Uri.encodeComponent(name)}"
      "&phone=$phone"
      "&city=${Uri.encodeComponent(city)}"
      "&bus=${Uri.encodeComponent(bus)}"
      "&stop=${Uri.encodeComponent(stop)}"
      "&password=${Uri.encodeComponent(password)}",
    );
    final response = await http.get(url);
    return response.body;
  }

  static Future<Map<String, dynamic>?> loginUser(
    String phone,
    String password,
  ) async {
    final url = Uri.parse(
      "$userSheetUrl?action=login&phone=$phone&password=${Uri.encodeComponent(password)}",
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') return data;
    return null;
  }

  // ---------------------- ATTENDANCE ----------------------

  static Future<String> markAttendance(
    String name,
    String phone,
    String city,
    String bus,
    String stop,
  ) async {
    final url = Uri.parse(
      "$attendanceSheetUrl?action=markAttendance"
      "&name=${Uri.encodeComponent(name)}"
      "&phone=$phone"
      "&city=${Uri.encodeComponent(city)}"
      "&bus=${Uri.encodeComponent(bus)}"
      "&stop=${Uri.encodeComponent(stop)}",
    );
    final response = await http.get(url);
    return response.body;
  }

  static Future<List<Map<String, dynamic>>> getDailyAttendance() async {
    final url = Uri.parse("$attendanceSheetUrl?action=getDailyAttendance");
    final response = await http.get(url);
    final List data = jsonDecode(response.body);
    return data
        .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // ---------------------- ADMIN ----------------------

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final url = Uri.parse("$userSheetUrl?action=getAllUsers");
    final response = await http.get(url);
    final List data = jsonDecode(response.body);
    return data
        .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> getAllAttendance() async {
    final url = Uri.parse("$attendanceSheetUrl?action=getAllAttendance");
    final response = await http.get(url);
    final List data = jsonDecode(response.body);
    return data
        .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> getAttendanceByDate(String date) async {
    final url = Uri.parse("$attendanceSheetUrl?action=getAttendanceByDate&date=$date");
    final response = await http.get(url);
    final List data = jsonDecode(response.body);
    return data.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
  }
}
