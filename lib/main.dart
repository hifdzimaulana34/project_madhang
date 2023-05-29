import 'package:flutter/material.dart';
import 'package:project_madhang/counter.dart';
import 'package:project_madhang/inputMenu.dart';
import 'package:project_madhang/adminListMenu.dart';
import 'package:project_madhang/adminHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/inputMenu': (context) => const InputMenu(),
        '/adminListMenu': (context) => const ListViewPage(),
        '/adminHome': (context) => const adminHomePage(),
        '/login': (context) => LoginPage(),
        '/countMeja': (context) => const CounterPage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void login(BuildContext context) {
    // Authenticate the user and determine the user's access level
    // Replace this with your own authentication logic
    final String username = usernameController.text;
    final String password = passwordController.text;

    // Here, you can replace the condition with your own logic to determine user access level
    if (username == 'admin' && password == 'admin') {
      Navigator.pushReplacementNamed(context, '/inputMenu');
    } else {
      Navigator.pushReplacementNamed(context, '/adminHome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => login(context),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Welcome, User!'),
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: const Center(
        child: Text('Welcome, Admin!'),
      ),
    );
  }
}
