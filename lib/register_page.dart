import 'package:flutter/material.dart';
import 'dart:math';
import 'http_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();
  final stopController = TextEditingController();
  final passwordController = TextEditingController();

  String generatedUid = "";
  String selectedCity = "Rajkot";

  final List<String> cities = [
    "Rajkot",
    "Morbi",
    "Wankaner",
    "Gondal",
    "Tankara",
    "Jasdan",
  ];

  String generateUid(String name) {
    final random = Random();
    String prefix = name.toLowerCase().replaceAll(' ', '').substring(0, 3);
    String number = (1000 + random.nextInt(9000)).toString();
    return prefix + number;
  }

  void register() async {
    String firstName = firstNameController.text.trim();
    String phone = phoneController.text.trim();
    String stop = stopController.text.trim();
    String password = passwordController.text.trim();

    if (firstName.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("First name must be at least 3 characters")),
      );
      return;
    }

    if (password.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 4 characters")),
      );
      return;
    }

    String uid = generateUid(firstName);
    setState(() {
      generatedUid = uid;
    });

    final result = await HttpService.registerUser(
      firstName,
      phone,
      selectedCity,
      stop,
      password,
      uid,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: "First Name"),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              DropdownButtonFormField<String>(
                value: selectedCity,
                onChanged: (value) {
                  setState(() {
                    selectedCity = value!;
                  });
                },
                decoration: InputDecoration(labelText: "City"),
                items: cities
                    .map(
                      (city) => DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      ),
                    )
                    .toList(),
              ),
              TextField(
                controller: stopController,
                decoration: InputDecoration(labelText: "Stop"),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(child: Text("Register"), onPressed: register),
              if (generatedUid.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Generated UID: $generatedUid",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
