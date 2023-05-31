import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_madhang/menuDetailPage.dart';
import 'package:project_madhang/reservasiMeja.dart';

class userListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyRestaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userListViewPage(),
      routes: {
        '/reservasi': (context) => reservasiPage(),
      },
    );
  }
}

class userListViewPage extends StatefulWidget {
  @override
  _userListViewPageState createState() => _userListViewPageState();
}

class _userListViewPageState extends State<userListViewPage> {
  Future<List<DocumentSnapshot>> _fetchFirestoreDocuments() async {
    await Firebase.initializeApp();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('MyRestaurant').get();

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu MyRestaurant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
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
                      String documentText = document['Nama Makanan'];

                      return ListTile(
                        title: Text(documentText),
                        trailing: ElevatedButton(
                          onPressed: () {
                            _navigateToDetailsPage(document);
                          },
                          child: Text('Pilih'),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/reservasi');
            },
            child: Text('Reservasi Meja'),
          ),
        ],
      ),
    );
  }
}
