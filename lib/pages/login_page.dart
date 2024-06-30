import 'package:flutter/material.dart';
import 'package:tugas_uas/page_home/home_page.dart';
import 'package:tugas_uas/pages/register_page.dart';
import 'package:tugas_uas/database/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showDialog('Login Gagal', 'Email dan password tidak boleh kosong.');
      return;
    }

    final user = await _databaseHelper.getUser(email);

    if (user != null && user['password'] == password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      _showDialog('Login Gagal', 'Email atau password salah.');
    }
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.pink[200]), // Warna label teks
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.pink[200]), // Warna label teks
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: _goToRegister,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
