import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class reservasiPage extends StatefulWidget {
  @override
  _reservasiPageState createState() => _reservasiPageState();
}

class _reservasiPageState extends State<reservasiPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter < 12) {
        _counter++;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _submitCounter() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference orderCollection = firestore.collection('Order');
    DocumentReference myOrderDocument = orderCollection.doc('MyOrder');

    if (_counter == 0) {
      myOrderDocument
          .update({'Jumlah reservasi': FieldValue.delete()}).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reservasi berhasil dibatalkan!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terdapat kesalahan field: $error')),
        );
      });
    } else {
      myOrderDocument.update({'Jumlah reservasi': _counter}).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil melakukan reservasi!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terdapat kesalahan: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jumlah Reservasi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_counter',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: Icon(Icons.remove),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitCounter,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
