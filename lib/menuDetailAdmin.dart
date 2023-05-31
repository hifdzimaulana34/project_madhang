import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class menuDetailAdmin extends StatelessWidget {
  final DocumentSnapshot? document;
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Order');

  menuDetailAdmin({required this.document});

  @override
  Widget build(BuildContext context) {
    if (document == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Document Details'),
        ),
        body: Center(
          child: Text('Document not found.'),
        ),
      );
    }

    final data = document!.data() as Map<String, dynamic>?;

    void addToOrderCollection(String? restaurantName, int counterValue) {
      if (restaurantName != null) {
        if (counterValue == 0) {
          orderCollection.doc('MyOrder').update({
            restaurantName: FieldValue.delete(),
          });
        } else {
          orderCollection.doc('MyOrder').update({
            restaurantName: FieldValue.increment(counterValue),
          });
        }
      }
    }

    int counterValue = 0;

    void incrementCounter(String? restaurantName) {
      counterValue++;
      addToOrderCollection(restaurantName, counterValue);
    }

    void decrementCounter(String? restaurantName) {
      if (counterValue > 0) {
        counterValue--;
      }
      addToOrderCollection(restaurantName, counterValue);
    }

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
        ],
      ),
    );
  }
}
