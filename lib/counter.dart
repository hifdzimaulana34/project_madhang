import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class counter extends StatelessWidget {
  const counter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  Future<void> _fetchCounterValue() async {
    // Retrieve the value from Firestore
    await Firebase.initializeApp();
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Meja')
        .doc('MejaTersedia')
        .get();
    if (snapshot.exists) {
      setState(() {
        counter = snapshot['Jumlah'];
      });
    }
  }

  Future<void> _incrementCounter() async {
    setState(() {
      counter++;
    });
    // Update the value in Firestore
    await FirebaseFirestore.instance
        .collection('Meja')
        .doc('MejaTersedia')
        .update({'Jumlah': counter});
  }

  Future<void> _decrementCounter() async {
    setState(() {
      counter--;
    });
    // Update the value in Firestore
    await FirebaseFirestore.instance
        .collection('Meja')
        .doc('MejaTersedia')
        .update({'Jumlah': counter});
  }

  @override
  void initState() {
    super.initState();
    _fetchCounterValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Jumlah: $counter',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Text('-'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('+'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
