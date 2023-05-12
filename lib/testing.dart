import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Add Collection Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('newCollection');

  void addDocument() async {
    try {
      await collectionRef.add({
        'field1': 'value1',
        'field2': 'value2',
      });
      print('Document added successfully');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Add Collection Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: addDocument,
          child: Text('Add Document'),
        ),
      ),
    );
  }
}