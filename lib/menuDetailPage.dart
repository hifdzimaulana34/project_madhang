import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class menuDetailpage extends StatefulWidget {
  final DocumentSnapshot? document;

  menuDetailpage({required this.document});

  @override
  _menuDetailpageState createState() => _menuDetailpageState();
}

class _menuDetailpageState extends State<menuDetailpage> {
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Order');

  int counterValue = 0;

  void addToOrderCollection(String? restaurantName, int counterDifference) {
    if (restaurantName != null) {
      int newCounterValue = counterValue + counterDifference;
      if (newCounterValue <= 0) {
        orderCollection.doc('MyOrder').update({
          restaurantName: FieldValue.delete(),
        });
        setState(() {
          counterValue = 0;
        });
      } else {
        orderCollection.doc('MyOrder').update({
          restaurantName: FieldValue.increment(counterDifference),
        });
        setState(() {
          counterValue = newCounterValue;
        });
      }
    }
  }

  void incrementCounter(String? restaurantName) {
    addToOrderCollection(restaurantName, 1);
  }

  void decrementCounter(String? restaurantName) {
    if (counterValue > 0) {
      addToOrderCollection(restaurantName, -1);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.document == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Document Details'),
        ),
        body: Center(
          child: Text('Document not found.'),
        ),
      );
    }

    final data = widget.document!.data() as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Menu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                if (data != null)
                  for (var field in data.keys)
                    ListTile(
                      title: Text(field),
                      subtitle: Text(data[field].toString()),
                    ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter: $counterValue',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        incrementCounter(data?['Nama Makanan']);
                      },
                      child: Text('Tambahkan'),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        decrementCounter(data?['Nama Makanan']);
                      },
                      child: Text('Kurangi'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
