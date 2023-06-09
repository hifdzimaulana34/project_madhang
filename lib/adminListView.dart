import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_madhang/inputMenu.dart';
import 'package:project_madhang/menuDetailAdmin.dart';

class adminListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyRestaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: adminListViewPage(),
      routes: {
        '/inputMenu': (context) => const InputMenu(),
      },
    );
  }
}

class adminListViewPage extends StatefulWidget {
  @override
  _adminListViewPageState createState() => _adminListViewPageState();
}

class _adminListViewPageState extends State<adminListViewPage> {
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
        builder: (context) => menuDetailAdmin(document: document),
      ),
    );
  }

  @override
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
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/inputMenu');
            },
            child: Text('Add Menu'),
          ),
        ],
      ),
    );
  }
}
