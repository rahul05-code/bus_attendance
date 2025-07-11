import 'package:flutter/material.dart';
import 'http_service.dart';

class AdminUserListPage extends StatefulWidget {
  @override
  _AdminUserListPageState createState() => _AdminUserListPageState();
}

class _AdminUserListPageState extends State<AdminUserListPage> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    final data = await HttpService.getAllUsers();
    setState(() => users = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registered Users")),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text("${user['city']} • ${user['phone']}"),
                  trailing: Text(user['stop']),
                );
              },
            ),
    );
  }
}
