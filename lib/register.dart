import 'package:flutter/material.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
    bool isPasswordToggle = false,
    VoidCallback? toggleVisibility,
    bool isPasswordVisible = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: obscure && !isPasswordVisible,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black),
          suffixIcon: isPasswordToggle
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
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

  void _createAccount() {
    // You can add validation and actual sign-up logic here
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage('Please fill all fields');
    } else if (password != confirmPassword) {
      _showMessage('Passwords do not match');
    } else {
      _showMessage('Account created successfully!');
      // Navigate or store data here
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(Icons.person_add_alt, size: 100, color: Colors.black),
              SizedBox(height: 10),
              Text(
                'Sign up',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              _buildTextField(
                hint: 'Name',
                icon: Icons.person,
                controller: nameController,
              ),
              _buildTextField(
                hint: 'email',
                icon: Icons.email,
                controller: emailController,
              ),
              _buildTextField(
                hint: 'Password',
                icon: Icons.lock,
                controller: passwordController,
                obscure: true,
                isPasswordToggle: true,
                toggleVisibility: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                isPasswordVisible: passwordVisible,
              ),
              _buildTextField(
                hint: 'Confirm Password',
                icon: Icons.lock,
                controller: confirmPasswordController,
                obscure: true,
                isPasswordToggle: true,
                toggleVisibility: () {
                  setState(() {
                    confirmPasswordVisible = !confirmPasswordVisible;
                  });
                },
                isPasswordVisible: confirmPasswordVisible,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _createAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
