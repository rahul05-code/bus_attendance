import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static const String baseUrl =
      "https://script.google.com/macros/s/AKfycbytkHiI4Pp7AQsHHcTnRk9Gf1rJFpaYyJbCyslHlOU9Ih2cq11XJWPZ9yDwvzI0rI6kNA/exec";

  static Future<String> registerUser(
    String firstName,
    String phone,
    String city,
    String stop,
    String password,
    String uid,
  ) async {
    final url = Uri.parse(
      "$baseUrl?action=register&name=$firstName&phone=$phone&city=$city&stop=$stop&password=$password&uid=$uid",
    );
    final response = await http.get(url);
    return response.body;
  }

  static Future<Map<String, dynamic>?> loginUser(
    String phone,
    String password,
  ) async {
    final url = Uri.parse(
      "$baseUrl?action=login&phone=$phone&password=$password",
    );
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (data['status'] == 'success') return data;
    return null;
  }

  static Future<String> markAttendance(
    String uid,
    String name,
    String phone,
    String city,
    String stop,
  ) async {
    final url = Uri.parse(
      "$baseUrl?action=markAttendance"
      "&uid=$uid&name=$name&phone=$phone&city=$city&stop=$stop",
    );
    final response = await http.get(url);
    return response.body;
  }

  static Future<List<Map<String, dynamic>>> getDailyAttendance() async {
    final url = Uri.parse("$baseUrl?action=getDailyAttendance");
    final response = await http.get(url); // changed from POST to GET
    final List data = jsonDecode(response.body);
    return data
        .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
