import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DbHelper {
  // Tables
  static String tblDocs = "docs";
  // Fields of the 'docs' table.
  String docId = "id";
  String docName = "name";
  String docEmail = "email";

  // Singleton
  static final DbHelper _dbHelper = DbHelper._internal();
  // Factory constructor
  DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }
  // Database entry point
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  // Initialize the database
  Future<Database> initializeDb() async {
    Directory d = await getApplicationDocumentsDirectory();
    String p = d.path + "/docexpire.db";
    var db = await openDatabase(p, version: 1, onCreate: _createDb);
    return db;
  }

  void _createDb(Database db, int version) async {
    return db.execute(
      "CREATE TABLE $tblDocs($docId INTEGER PRIMARY KEY, $docName TEXT, $docEmail TEXT)",
    );
  }

  // Insert a new doc
  Future<int> insertDoc(Map<String, dynamic> doc) async {
    var r;
    Database db = await this.db;
    try {
      r = await db.insert(tblDocs, doc);
    } catch (e) {
      debugPrint("insertDoc: " + e.toString());
    }
    return r;
  }

  // Get the list of docs.
  Future<List<Map<String, dynamic>>> getDocs() async {
    Database db = await this.db;
    var r = await db.rawQuery("SELECT * FROM $tblDocs ORDER BY $docId ASC");
    return r;
  }

  Future<List<Map<String, dynamic>>> getDoc(String name) async {
    Database db = await this.db;
    var r = await db
        .rawQuery("SELECT * FROM $tblDocs WHERE $docName = " + name + "");
    return r;
  }

  // Update a doc.
  Future<int> updateDoc(Map<String, dynamic> doc) async {
    var db = await this.db;
    var r = await db
        .update(tblDocs, doc, where: "$docId = ?", whereArgs: [doc['id']]);
    return r;
  }

  // Delete a doc.
  Future<int> deleteDoc(String name) async {
    var db = await this.db;
    int r = await db.rawDelete("DELETE FROM $tblDocs WHERE $docName = $name");
    return r;
  }
}
