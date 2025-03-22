import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

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

  bool _isPasswordVisible = false; // Track the visibility of the password

  // Function to send the registration data to the backend
  Future<void> _register() async {
    final String url = 'http://localhost:8080/api/users/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print('User registered successfully: $responseData');
        // Show success message
        Fluttertoast.showToast(
          msg: "Registration successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Navigate to the login page after successful registration
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        final responseData = json.decode(response.body);
        print('Registration failed: ${responseData['message']}');
        // Show error message using Toast
        Fluttertoast.showToast(
          msg: "Registration failed: ${responseData['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      print('Error during registration: $error');
      // Show error message using Toast for network or other errors
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
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

  // Reusable method for building text fields
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
