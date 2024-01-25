import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class readData extends StatefulWidget {
  const readData({super.key});

  @override
  State<readData> createState() => _readDataState();
}

class _readDataState extends State<readData> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reading data", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder(
            future: FirebaseFirestore.instance.collection("Users").get(),
            builder: (context, snap) {
              if (snap.hasData) {
                List users = snap.data!.docs;
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) => ListTile(
                            leading: Image.network(users[index]['image']),
                            trailing: Text(users[index]["Phone"].toString()),
                            title: Text(users[index]['Name' ?? ""]),
                            subtitle: Text(users[index]['Email'] ?? ""),
                          )),
                );
              } else if (snap.hasError)
                return Text("Error Occured");
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }));
  }
}
