import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Register user (phone as unique ID)
  static Future<String> registerUser({
    required String name,
    required String phone,
    required String city,
    required String bus,
    required String stop,
    required String password,
  }) async {
    final doc = _db.collection('users').doc(phone);
    final userDoc = await doc.get();

    if (userDoc.exists) return "Phone number already registered.";

    await doc.set({
      'name': name,
      'phone': phone,
      'city': city,
      'bus': bus,
      'stop': stop,
      'password': password,
    });
    return "User registered successfully";
  }

  // Login user
  static Future<Map<String, dynamic>?> loginUser(
      String phone, String password) async {
    final doc = await _db.collection('users').doc(phone).get();
    if (doc.exists && doc['password'] == password) {
      return doc.data()!;
    }
    return null;
  }

  // Mark attendance
  static Future<String> markAttendance(Map<String, dynamic> userData) async {
    final now = DateTime.now();
    await _db.collection('attendance').add({
      'phone': userData['phone'],
      'name': userData['name'],
      'city': userData['city'],
      'bus': userData['bus'],
      'stop': userData['stop'],
      'timestamp': now,
      'date': "${now.year}-${now.month}-${now.day}"
    });
    return "Attendance marked successfully";
  }

  // Get today's attendance
  static Future<List<Map<String, dynamic>>> getDailyAttendance() async {
    final today = DateTime.now();
    final date = "${today.year}-${today.month}-${today.day}";
    final snapshot = await _db
        .collection('attendance')
        .where('date', isEqualTo: date)
        .get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  // Admin: Get all users
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final snapshot = await _db.collection('users').get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  // Admin: Get all attendance
  static Future<List<Map<String, dynamic>>> getAllAttendance(DateTime selectedDate) async {
    final snapshot = await _db.collection('attendance').get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  // Get attendance by date
  static Future<List<Map<String, dynamic>>> getAttendanceByDate(
      String date) async {
    final snapshot = await _db
        .collection('attendance')
        .where('date', isEqualTo: date)
        .get();
    return snapshot.docs.map((e) => e.data()).toList();
  }
}
