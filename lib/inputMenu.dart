import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class InputMenu extends StatefulWidget {
  const InputMenu({super.key});

  @override
  _InputMenuState createState() => _InputMenuState();
}

class _InputMenuState extends State<InputMenu> {
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

      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("MyRestaurant")
          .doc(namaMakanan);

      Map<String, dynamic> makanan = {
        "Nama Makanan": namaMakanan,
        "Harga Makanan": hargaMakanan,
        "Deskripsi Makanan": deskripsiMakanan
      };

      await documentReference.set(makanan);

      print("Data $namaMakanan berhasil ditambahkan");
    } catch (e) {
      print("Error saat menambahkan data: $e");
    }
  }

  void readData() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection("MyRestaurant")
        .doc(namaMakanan)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          print(data["Nama Makanan"]);
          print(data["Harga Makanan"]);
          print(data["Deskripsi Makanan"]);
        }
      } else {
        print("Document tidak ada");
      }
    }).catchError((error) {
      print("Error: $error");
    });
  }

  editData() async {
    try {
      // Initialize Firebase app
      await Firebase.initializeApp();

      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("MyRestaurant")
          .doc(namaMakanan);

      Map<String, dynamic> makanan = {
        "Nama Makanan": namaMakanan,
        "Harga Makanan": hargaMakanan,
        "Deskripsi Makanan": deskripsiMakanan
      };

      await documentReference.set(makanan);

      print("Data berhasil diedit");
    } catch (e) {
      print("Error saat mengedit data: $e");
    }
  }

  deleteData() async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("MyRestaurant")
          .doc(namaMakanan);

      documentReference.delete().whenComplete(() {
        print("$namaMakanan telah dihapus");
      });
    } catch (e) {
      print("Error saat menghapus $namaMakanan");
    }
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
