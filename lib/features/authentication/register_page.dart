import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false; // Track the visibility of the password

  void _register() {
    print('Name: ${_nameController.text}');
    print('Username: ${_usernameController.text}');
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF6C63FF),
          ), // Updated to match new color palette
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
              Text(
                'Welcome to Kwizzle!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF493D9E), // Unique welcoming message color
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Let’s get you started on a fun quiz journey.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6C63FF), // Color matching the palette
                ),
              ),
              SizedBox(height: 24),
              _buildTextField(controller: _nameController, label: 'Full Name'),
              SizedBox(height: 12),
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
              ),
              SizedBox(height: 12),
              _buildTextField(controller: _emailController, label: 'Email'),
              SizedBox(height: 12),
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
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                    0xFF6C63FF,
                  ), // Updated to match new color palette
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Already have an account? Sign In.",
                  style: TextStyle(
                    color: Color(0xFF6C63FF),
                  ), // Updated to match new color palette
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
        labelStyle: TextStyle(color: Color(0xFF6C63FF)), // Updated label color
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
