import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  late Future<QuerySnapshot<Map<String, dynamic>>> _listFuture;

  @override
  void initState() {
    super.initState();
    _listFuture = _fetchListData();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _fetchListData() async {
    await Firebase.initializeApp();
    final snapshot =
        await FirebaseFirestore.instance.collection('MyRestaurant').get();
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List makanan dari MyRestaurant'),
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _listFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data!.docs;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                final itemData = item.data();

                final text1 = itemData['Nama Makanan'] as String;
                final text2 = itemData['Harga Makanan'] as String;
                final text3 = itemData['Deskripsi Makanan'] as String;

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Makanan: $text1"),
                      Text("Harga Makanan: $text2"),
                      Text("Deskripsi: $text3"),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
