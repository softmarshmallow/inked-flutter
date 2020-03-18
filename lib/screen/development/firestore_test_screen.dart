import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreTestScreen extends StatefulWidget {
  static const routeName = "development/firestore";
  FirestoreTestScreen({Key key}) : super(key: key);

  @override
  _FirestoreTestScreenState createState() => _FirestoreTestScreenState();
}

class _FirestoreTestScreenState extends State<FirestoreTestScreen> {
  @override
  Widget build(BuildContext context) {
    _load();
    return Container();
  }
  
  
  _load(){
    Firestore.instance.collection('hero').add({"i": "ironman", "at": DateTime.now().toIso8601String()});

//    Firestore.instance.collection('diaries').document('monday').updateData(data);

//    Firestore.instance.collection('diaries').document('monday').delete();
  }
}