import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;

  Future<void> _register() async {
    if (_nameController.text.isEmpty) {
      _showCustomSnackBar("Full Name is required!", Colors.red);
      return;
    }
    if (_usernameController.text.isEmpty) {
      _showCustomSnackBar("Username is required!", Colors.red);
      return;
    }
    if (_emailController.text.isEmpty) {
      _showCustomSnackBar("Email is required!", Colors.red);
      return;
    }
    if (_passwordController.text.isEmpty) {
      _showCustomSnackBar("Password is required!", Colors.red);
      return;
    }

    final String url = 'http://10.0.2.2:8080/api/users/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'role': 'USER',
          'status': 'ACTIVE',
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        String token = responseData['data']['token'];

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('auth_token', token);

        // Show success SnackBar at the top
        _showCustomSnackBar("Registration successful!", Colors.green);
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        final responseData = json.decode(response.body);
        _showCustomSnackBar(responseData['pesan'], Colors.red);
      }
    } catch (error) {
      _showCustomSnackBar(
        "An error occurred. Please try again. $error",
        Colors.red,
      );
    }
  }

  // Custom SnackBar for top of the screen
  void _showCustomSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
              Text(
                'Welcome to Kwizzle!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Let’s get you started on a fun quiz journey.',
                style: TextStyle(fontSize: 16, color: Color(0xFF6C63FF)),
              ),
              SizedBox(height: 40),
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                focusNode: _nameFocusNode,
                nextFocusNode: _usernameFocusNode,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
                focusNode: _usernameFocusNode,
                nextFocusNode: _emailFocusNode,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                focusNode: _emailFocusNode,
                nextFocusNode: _passwordFocusNode,
              ),
              SizedBox(height: 12),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: !_isPasswordVisible,
                focusNode: _passwordFocusNode,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xFF6C63FF),
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
                  backgroundColor: Color(0xFF6C63FF),
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
                  style: TextStyle(color: Color(0xFF6C63FF)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6C63FF)),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: suffixIcon,
      ),
      textInputAction:
          nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      onEditingComplete: () {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }
}
