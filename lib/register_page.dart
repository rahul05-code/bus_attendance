import 'package:flutter/material.dart';
import 'http_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final stopController = TextEditingController();
  final passwordController = TextEditingController();

  String selectedCity = "Rajkot";
  String selectedBus = "Morbi (Big)";

  final List<String> cities = [
    "Rajkot",
    "Morbi",
    "Tankara",
    "Jasdan",
    "Wankaner",
    "Gondal",
  ];

  final List<String> buses = [
    "Morbi (Big)",
    "Morbi (Small)",
    "Rajkot",
    "Gondal (Big)",
    "Gondal (Small)",
    "Wankaner",
    "Jasdan",
  ];

  void register() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String stop = stopController.text.trim();
    String password = passwordController.text.trim();

    if (name.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Name must be at least 3 characters")),
      );
      return;
    }

    if (phone.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter valid 10-digit mobile number")),
      );
      return;
    }

    if (password.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 4 characters")),
      );
      return;
    }

    final result = await HttpService.registerUser(
      name,
      phone,
      selectedCity,
      selectedBus,
      stop,
      password,
      phone, // phone as UID
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
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Mobile No"),
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
                      (city) =>
                          DropdownMenuItem(value: city, child: Text(city)),
                    )
                    .toList(),
              ),
              DropdownButtonFormField<String>(
                value: selectedBus,
                onChanged: (value) {
                  setState(() {
                    selectedBus = value!;
                  });
                },
                decoration: InputDecoration(labelText: "Bus"),
                items: buses
                    .map(
                      (bus) => DropdownMenuItem(value: bus, child: Text(bus)),
                    )
                    .toList(),
              ),
              TextField(
                controller: stopController,
                decoration: InputDecoration(labelText: "Bus Stop"),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(child: Text("Register"), onPressed: register),
            ],
          ),
        ),
      ),
    );
  }
}
