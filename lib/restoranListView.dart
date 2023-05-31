import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_madhang/menuDetailPage.dart';
import 'package:project_madhang/userListView.dart';

class restoranListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyRestaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: restoranListViewPage(),
      routes: {
        '/userListView': (context) => userListView(),
      },
    );
  }
}

class restoranListViewPage extends StatefulWidget {
  const restoranListViewPage({super.key});
  @override
  _restoranListViewPageState createState() => _restoranListViewPageState();
}

class _restoranListViewPageState extends State<restoranListViewPage> {
  Future<List<DocumentSnapshot>> _fetchFirestoreDocuments() async {
    await Firebase.initializeApp();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Meja').get();

    return querySnapshot.docs;
  }

  void _navigateToDetailsPage(DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => menuDetailpage(document: document),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu MyRestaurant'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _fetchFirestoreDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<DocumentSnapshot>? documents = snapshot.data;
            return ListView.builder(
              itemCount: documents!.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = documents[index];
                num documentText = document['Jumlah'];
                String jumlahMeja = documentText.toString();

                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey, // Set the desired color for the box
                        borderRadius: BorderRadius.circular(
                            10), // Set the desired border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('MyRestaurant'),
                            Text('Jumlah meja tersedia: ' + jumlahMeja),
                          ],
                        ),
                      ),
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/userListView');
                    },
                    child: Text('Menu'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
