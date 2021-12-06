import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import 'addnote.dart';
import 'editnote.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('notes app'),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Addnote()));
              },
            ),
            body: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount:
                        snapshot.hasData ? snapshot.data!.docs.length : 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Editnote(
                                        de: snapshot.data!.docs[index],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 150,
                          color: Colors.grey[200],
                          child: Column(
                            children: [
                              Text(snapshot.data!.docs[index]['title']),
                              Text(snapshot.data!.docs[index]['note'])
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })));
  }
}
