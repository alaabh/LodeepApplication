import 'dart:async';
import 'package:flutter_project/v2/utils/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Stockdatabase {
  static Database? database;

  static Future<Database> getDatabase() async {
    return database ??= await initDatabase();
  }

  static Future<Database> initDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), "gestionLivre.db"),
        version: 1,
        onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $CATEGORY_TABLE (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT UNIQUE NOT NULL
      )
      ''');

    await db.execute('''CREATE TABLE $MEMBER_TABLE  (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      firstName TEXT NOT NULL,
      lastName  TEXT NOT NULL,
      number  INTEGER NOT NULL,
      cinNumber  INTEGER NOT NULL
      )
      ''');

    await db.execute('''CREATE TABLE $BOOKS_TABLE  (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      addedAt STRING NOT NULL,
      quantity INTEGER NOT NULL,
      category INTEGER NOT NULL,
      FOREIGN KEY(category) REFERENCES $CATEGORY_TABLE(id)
      )
      ''');

    await db.execute('''CREATE TABLE $LOAN_TABLE  (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      quantity INTEGER NOT NULL,
      member  INTEGER NOT NULL,
      bookId  INTEGER NOT NULL,
      isReturned  BOOLEAN DEFAULT(FALSE),
      returnedAt REAL ,
      state TEXT,
      FOREIGN KEY(bookId) REFERENCES $BOOKS_TABLE(id),
      FOREIGN KEY(member) REFERENCES $MEMBER_TABLE(id)
      )
      ''');
  }
}
