import 'package:flutter/material.dart';

class adminHomePage extends StatelessWidget {
  const adminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Homepage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/countMeja');
              },
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(135, 50))),
              child: const Padding(
                padding: EdgeInsets.all(1.0),
                child: Text('Counter'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inputMenu');
              },
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(50, 50))),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Menu Input'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/adminListMenu');
              },
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(50, 50))),
              child: const Padding(
                padding: EdgeInsets.all(1.0),
                child: Text('Daftar Makanan'),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(135, 50))),
              child: const Padding(
                padding: EdgeInsets.all(1.0),
                child: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
