import 'package:flutter/material.dart';
import 'results.dart'; // ✅ Import result screen

void main() {
  runApp(HealthAnalysisApp());
}

class HealthAnalysisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HealthFormScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HealthFormScreen extends StatelessWidget {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController bpController = TextEditingController();
  final TextEditingController sugarController = TextEditingController();

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  void _startAnalysis(BuildContext context) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Analysis"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your information',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              _buildTextField('Enter age', ageController),
              _buildTextField('Cholesterol level', cholesterolController),
              _buildTextField('blood pressure', bpController),
              _buildTextField('sugar level', sugarController),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _startAnalysis(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Start analysis',
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
