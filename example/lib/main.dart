import 'package:flutter/material.dart';
import 'package:parsing_util/parsing_util.dart';

/// A simple model with two fields
class UserModel {
  final String name;
  final int age;

  UserModel({required this.name, required this.age});

  /// Factory that uses ParsingUtil to safely parse values
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: ParsingUtil.toSafeString(json['name'], defaultValue: 'Unknown'),
      age: ParsingUtil.toSafeInt(json['age'], defaultValue: 0),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Example JSON data (name is null, age is a string)
    final json = {"name": null, "age": "25"};

    final user = UserModel.fromJson(json);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ParsingUtil Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Name: ${user.name}"),
              Text("Age: ${user.age}"),
              const SizedBox(height: 20),
              Text("Safe String: ${ParsingUtil.toSafeString(null, defaultValue: 'N/A')}"),
              Text("Safe Int: ${ParsingUtil.toSafeInt('42')}"),
              Text("Safe Double: ${ParsingUtil.toSafeDouble('3.14')}"),
              Text("Safe Boolean: ${ParsingUtil.toSafeBoolean('true')}"),
              Text("String Extension: ${'hello'.orEmpty()}"),
              Text("Null String Extension: ${(null as String?).orEmpty()}"),
            ],
          ),
        ),
      ),
    );
  }
}
