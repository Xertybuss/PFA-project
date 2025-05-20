import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/login.dart';
import 'package:project/results.dart';

void main() {
  runApp(LoginApp());
}

class HealthAnalysisApp extends StatelessWidget {
  const HealthAnalysisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HealthFormScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HealthFormScreen extends StatefulWidget {
  const HealthFormScreen({super.key});

  @override
  State<HealthFormScreen> createState() => _HealthFormScreenState();
}

class _HealthFormScreenState extends State<HealthFormScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController bpController = TextEditingController();
  final TextEditingController sugarController = TextEditingController();

  Future<Map<String, dynamic>> startAnalysis(
    String age,
    String cholesterol,
    String bp,
    String sugar,
  ) async {
    final url = Uri.parse("http://127.0.0.1:5000/api/start-analysis"); // Adjusted for Android Emulator

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'age': age,
          'cholesterol': cholesterol,
          'blood_pressure': bp,
          'sugar_level': sugar,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          throw 'Unexpected data format';
        }
      } else {
        throw 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error occurred: $e';
    }
  }

  void _handleStartAnalysis() async {
    String age = ageController.text.trim();
    String cholesterol = cholesterolController.text.trim();
    String bloodPressure = bpController.text.trim();
    String sugarLevel = sugarController.text.trim();

    if (age.isEmpty || cholesterol.isEmpty || bloodPressure.isEmpty || sugarLevel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      Map<String, dynamic> result = await startAnalysis(age, cholesterol, bloodPressure, sugarLevel);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(data: result),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Analysis"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter your information',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                _buildTextField('Enter age', ageController),
                _buildTextField('Cholesterol level', cholesterolController),
                _buildTextField('Blood pressure', bpController),
                _buildTextField('Sugar level', sugarController),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _handleStartAnalysis,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Start analysis',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
