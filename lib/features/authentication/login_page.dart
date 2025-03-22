import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false; // Track the visibility of the password

  void _login() {
    print('Username: ${_usernameController.text}');
    print('Password: ${_passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF6C63FF)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              // Welcome Back Text
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please log in to continue your quiz journey.',
                style: TextStyle(fontSize: 16, color: Color(0xFF6C63FF)),
              ),
              SizedBox(height: 24),
              // Username Field
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
                obscureText: false,
              ),
              SizedBox(height: 12),
              // Password Field
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xFF6C63FF), // Updated icon color
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 24),
              // Login Button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                    0xFF6C63FF,
                  ), // Updated color for the button
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              // Sign Up Link
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "Don't have an account? Sign up here.",
                  style: TextStyle(color: Color(0xFF6C63FF)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method for building text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black), // Keep label text black
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF6C63FF),
          ), // Updated focused border color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
