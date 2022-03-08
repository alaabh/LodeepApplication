import 'package:flutter_project/v2/db/dbcreation.dart';

import 'package:flutter_project/v2/model/member.model.dart';
import 'package:flutter_project/v2/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class MemberService {
  Future<List<Member>> loadAllMembers() async {
    var db = await Stockdatabase.getDatabase();
    List<Map<String, Object?>> membersList = await db.query(MEMBER_TABLE);
    List<Member> list = [];
    for (var element in membersList) {
      list.add(Member.fromMap(element));
    }
    return list;
  }

  Future<int> addMember(Member member) async {
    var db = await Stockdatabase.getDatabase();
    return db.insert(
      MEMBER_TABLE,
      member.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
