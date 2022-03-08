import 'package:flutter_project/v2/db/dbcreation.dart';
import 'package:flutter_project/v2/model/book.model.dart';
import 'package:flutter_project/v2/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class BookService {
  Future<List<Book>> loadAllBooks() async {
    var db = await Stockdatabase.getDatabase();
    List<Map<String, Object?>> bookList = await db.query(BOOKS_TABLE);
    List<Book> list = [];
    for (var element in bookList) {
      list.add(Book.fromMap(element));
    }
    return list;
  }

  

  Future<Book> searchBookById(int id) async {
    var db = await Stockdatabase.getDatabase();
    List<Map<String, Object?>> bookList =
        await db.query(BOOKS_TABLE, where: "id = ?", whereArgs: [id]);
    return Book.fromMap(bookList.first);
  }

  Future<int> addBook(Book book) async {
    var db = await Stockdatabase.getDatabase();
    return db.insert(
      BOOKS_TABLE,
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateQuantity(int id, int quantity) async {
    var db = await Stockdatabase.getDatabase();
    return await db.update(
        BOOKS_TABLE,
        {
          'quantity': quantity,
        },
        where: "id = ?",
        whereArgs: [id]);
  }
}
