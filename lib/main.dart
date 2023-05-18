import 'package:flutter/material.dart';
import 'package:project_madhang/inputMenu.dart';
import 'package:project_madhang/adminListMenu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elevated Button Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/inputMenu': (context) => InputMenu(),
        '/adminListMenu': (context) => ListViewPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Homepage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Menu Input'),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/inputMenu');
              },
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(50, 50))),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text('Daftar Makanan'),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/adminListMenu');
              },
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(50, 50))),
            ),
          ],
        ),
      ),
    );
  }
}
