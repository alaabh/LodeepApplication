import 'package:flutter_project/v2/db/dbcreation.dart';
import 'package:flutter_project/v2/model/loaned_object.model.dart';
import 'package:flutter_project/v2/model/loans.model.dart';
import 'package:flutter_project/v2/service/Book.service.dart';
import 'package:flutter_project/v2/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class LoanService {
  //add

  Future<int> addLoan(Loan loan) async {
    var db = await Stockdatabase.getDatabase();
    var book =
        await BookService().searchBookById(loan.bookId);
    var newQuantity = book.quantity - loan.quantity;
    if (newQuantity < 0) {
      return -1;
    }
    BookService().updateQuantity(loan.bookId, newQuantity);
    return db.insert(
      LOAN_TABLE,
      loan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //update when returned

  Future<int> updateLoanState(
      int loanId, int bookId, int quantity, String state) async {
    var db = await Stockdatabase.getDatabase();
    var book = await BookService().searchBookById(bookId);
    var newQuantity = book.quantity + quantity;
    BookService().updateQuantity(bookId, newQuantity);

    return await db.update(
        LOAN_TABLE,
        {
          'state': state,
          'isReturned': true,
          'returnedAt': DateTime.now().toString()
        },
        where: "id = ?",
        whereArgs: [loanId]);
  }

  Future<List<Loan>> loadAllLoans() async {
    var db = await Stockdatabase.getDatabase();
    List<Map<String, Object?>> loansList =
        await db.query(LOAN_TABLE, where: "isReturned = ?", whereArgs: [false]);
    List<Loan> list = [];
    for (var element in loansList) {
      list.add(Loan.fromMap(element));
    }
    return list;
  }

  Future<List<LoanedBook>> loadAllLoansDetails() async {
    var db = await Stockdatabase.getDatabase();
    List<Map<String, Object?>> loansList = await db.rawQuery(
        "SELECT loan.id, member.firstName, member.lastName, member.number, loan.quantity, loan.bookId, member.cinNumber , book.name FROM loan , member, book WHERE loan.member =  member.id AND loan.bookId = book.id AND loan.isReturned = false ");
    List<LoanedBook> list = [];
    for (var element in loansList) {
      list.add(LoanedBook.fromMap(element));
    }
    return list;
  }
}
