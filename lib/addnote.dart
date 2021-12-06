import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);

  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  final heading = TextEditingController();
  final note = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text("add a note"), actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                ref.add({
                  'title': heading.text,
                  'note': note.text
                }).whenComplete(() => Navigator.pop(context));
              })
        ]),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(height / 50),
              height: height / 10,
              child: TextField(
                  controller: heading,
                  decoration: const InputDecoration(hintText: 'Title')),
            ),
            Container(
                padding: EdgeInsets.all(height / 50),
                height: (height * 30) / 100,
                child: TextField(
                    expands: true,
                    maxLines: null,
                    controller: note,
                    decoration: const InputDecoration(hintText: 'content')))
          ],
        ));
  }
}
