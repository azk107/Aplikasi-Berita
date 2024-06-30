import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_uas/pages/login_page.dart';
import 'package:tugas_uas/pages/register_page.dart';
import 'package:tugas_uas/page_home/home_page.dart';
import 'package:tugas_uas/model/news_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
