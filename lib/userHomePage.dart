import 'package:flutter/material.dart';

class userHomePage extends StatelessWidget {
  const userHomePage({super.key});

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
                Navigator.pushNamed(context, '/inputMenu');
              },
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(50, 50))),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Cari Restoran'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
