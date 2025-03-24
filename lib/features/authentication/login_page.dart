import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> _login() async {
    if (_usernameController.text.isEmpty) {
      _showCustomSnackBar("Username is required!", Colors.red);
      return;
    }
    if (_passwordController.text.isEmpty) {
      _showCustomSnackBar("Password is required!", Colors.red);
      return;
    }

    final String url = 'http://10.0.2.2:8080/api/users/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['sukses']) {
          String token = responseData['data']?['token'] ?? '';
          int userId = responseData['data']?['id'] ?? 0;
          String name = responseData['data']?['name'] ?? '';
          String username = responseData['data']?['username'] ?? '';
          String email = responseData['data']?['email'] ?? '';
          String role =
              responseData['data']?['role'] ?? ''; // Ambil role pengguna

          if (token.isEmpty) {
            _showCustomSnackBar(
              "Token is missing. Please try again.",
              Colors.red,
            );
            return;
          }

          final prefs = await SharedPreferences.getInstance();
          prefs.setString('auth_token', token);
          prefs.setInt('user_id', userId);
          prefs.setString('name', name);
          prefs.setString('username', username);
          prefs.setString('email', email);
          prefs.setString('role', role); // Simpan role di SharedPreferences

          _showCustomSnackBar("Login successful!", Colors.green);

          if (role.toLowerCase() == 'admin') {
            Navigator.pushReplacementNamed(
              context,
              '/adminHome',
            ); // Halaman admin
          } else {
            Navigator.pushReplacementNamed(
              context,
              '/userhome',
            ); // Halaman user
          }
        } else {
          String errorMessage = responseData['pesan'] ?? "Login failed";
          _showCustomSnackBar(errorMessage, Colors.red);
        }
      } else {
        final responseData = json.decode(response.body);
        String errorMessage = responseData['pesan'] ?? "Unknown error occurred";
        _showCustomSnackBar(errorMessage, Colors.red);
      }
    } catch (error) {
      _showCustomSnackBar(
        "An error occurred. Please try again. $error",
        Colors.red,
      );
    }
  }

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
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
                obscureText: false,
              ),
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
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6C63FF),
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
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6C63FF)),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
