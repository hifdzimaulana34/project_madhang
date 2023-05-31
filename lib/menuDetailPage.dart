import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class menuDetailpage extends StatelessWidget {
  final DocumentSnapshot? document;

  menuDetailpage({required this.document});

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Makanan'),
      ),
      body: ListView(
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
    );
  }
}
