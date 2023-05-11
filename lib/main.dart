import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),
      home: const MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String namaMakanan, hargaMakanan, deskripsiMakanan;

  getName(nama) {
    namaMakanan = nama;
  }

  getHarga(harga) {
    hargaMakanan = harga;
  }

  getDeskripsi(deskripsi) {
    deskripsiMakanan = deskripsi;
  }

  void createData() async {
    try {
      // Initialize Firebase app
      await Firebase.initializeApp();

      print("created");

      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("MyRestaurant")
          .doc(namaMakanan);

      Map<String, dynamic> makanan = {
        "Nama Makanan": namaMakanan,
        "Harga Makanan": hargaMakanan,
        "Deskripsi Makanan": deskripsiMakanan
      };

      await documentReference.set(makanan);

      print("Data added successfully");
    } catch (e) {
      print("Error adding data: $e");
    }
  }

  editData() {
    print("edited");
  }

  deleteData() {
    print("deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Madhang Crud Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Nama Makanan",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (nama) {
                  getName(nama);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Harga Makanan",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (harga) {
                  getHarga(harga);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Deskripsi Makanan",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (deskripsi) {
                  getDeskripsi(deskripsi);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      createData();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(10, 40))),
                    child: const Text("Tambah")),
                ElevatedButton(
                    onPressed: () {
                      editData();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(10, 40))),
                    child: const Text("Edit")),
                ElevatedButton(
                    onPressed: () {
                      deleteData();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(10, 40))),
                    child: const Text("Hapus")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
