import 'package:flutter/material.dart';
import './ui/home.dart';

void main() => runApp(DocExpiryApp());

class DocExpiryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FSqLite CRUD',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Home(),
    );
  }
}
