import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class orderUser extends StatefulWidget {
  @override
  _orderUserState createState() => _orderUserState();
}

class _orderUserState extends State<orderUser> {
  CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('Order');
  DocumentReference myOrderDoc = FirebaseFirestore.instance
      .collection('Order')
      .doc('MyOrder'); // Update with your specific document ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: myOrderDoc.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text('No data found');
          }

          // Retrieve the data from the document
          var orderData = snapshot.data!.data() as Map<String, dynamic>;

          // Display the data
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: orderData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item = orderData.keys.elementAt(index);
                    var quantity = orderData[item];

                    return ListTile(
                      title: Text(item),
                      subtitle: Text('Quantity: $quantity'),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _deleteOrder();
                },
                child: Text('Batalkan Pesanan'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _deleteOrder() async {
    try {
      await myOrderDoc.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order deleted successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete order.'),
        ),
      );
    }
  }
}
