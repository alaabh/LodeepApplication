import 'package:flutter_project/v2/db/dbcreation.dart';
import 'package:flutter_project/v2/model/category.model.dart';
import 'package:flutter_project/v2/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class CategoryService {
  Future<int> addCategory(Category category) async {
    var db = await Stockdatabase.getDatabase();
    return db.insert(
      CATEGORY_TABLE,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> loadAllCategories() async {
    var db = await Stockdatabase.getDatabase();
    List<Map<String, Object?>> categoriesList = await db.query(CATEGORY_TABLE);
    List<Category> list = [];
    for (var element in categoriesList) {
      print(element.values);
      list.add(Category.fromMap(element));
    }
    return list;
  }
}
