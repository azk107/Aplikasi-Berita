import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:tugas_uas/database/database_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  void _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showDialog('Pendaftaran Gagal', 'Email dan password tidak boleh kosong.');
      return;
    }

    final existingUser = await _databaseHelper.getUser(email);
    if (existingUser != null) {
      _showDialog('Pendaftaran Gagal', 'Email sudah terdaftar.');
      return;
    }

    Map<String, dynamic> user = {
      'email': email,
      'password': password,
    };
    await _databaseHelper.insertUser(user);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
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
        title: const Text('Register'),
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
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: _goToLogin,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
