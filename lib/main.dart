import 'package:flutter/material.dart';
import 'package:project_madhang/counter.dart';
import 'package:project_madhang/inputMenu.dart';
import 'package:project_madhang/adminListView.dart';
import 'package:project_madhang/adminHomePage.dart';
import 'package:project_madhang/orderAdmin.dart';
import 'package:project_madhang/orderUser.dart';
import 'package:project_madhang/reservasiMeja.dart';
import 'package:project_madhang/restoranListView.dart';
import 'package:project_madhang/userHomePage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/adminListView': (context) => adminListView(),
        '/listViewResto': (context) => restoranListView(),
        '/adminHome': (context) => const adminHomePage(),
        '/userHome': (context) => const userHomePage(),
        '/login': (context) => LoginPage(),
        '/countMeja': (context) => const CounterPage(),
        '/reservasi': (context) => reservasiPage(),
        '/userOrder': (context) => orderUser(),
        '/adminOrder': (context) => orderAdmin(),
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
      Navigator.pushReplacementNamed(context, '/adminHome');
    } else {
      Navigator.pushReplacementNamed(context, '/userHome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
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
