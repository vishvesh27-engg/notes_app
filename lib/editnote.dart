import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Editnote extends StatefulWidget {
  DocumentSnapshot de;
  Editnote({required this.de});

  @override
  _EditnoteState createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  var heading = TextEditingController();
  var note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    heading = TextEditingController(text: widget.de['title']);
    note = TextEditingController(text: widget.de['note']);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text("edit note"), actions: [
          IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                widget.de.reference.update({
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
