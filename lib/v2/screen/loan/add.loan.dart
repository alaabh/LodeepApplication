import 'package:flutter/material.dart';
import 'package:flutter_project/v2/model/book.model.dart';
import 'package:flutter_project/v2/model/loans.model.dart';
import 'package:flutter_project/v2/model/member.model.dart';
import 'package:flutter_project/v2/service/Book.service.dart';
import 'package:flutter_project/v2/service/loan.service.dart';

import 'package:flutter_project/v2/service/member.service.dart';
import 'package:get/get.dart';

class AddLoanPage extends StatefulWidget {
  AddLoanPage({Key? key}) : super(key: key);

  @override
  _AddLoanState createState() => _AddLoanState();
}

class _AddLoanState extends State<AddLoanPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  BookService myservice = BookService();
  BookService bookService = BookService();

  bool _validate = false;
  bool _validatep = false;
  bool _validateu = false;
  bool _validatepa = false;
  String? value;
  String? bookname;
  DateTime? dateacq;
  String? memberId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          memeberListWidget(),
          bookListWidget(),
          SizedBox(
            width: 400,
            child: TextField(
              controller: quantityController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'quantity',
                  errorText: _validate ? 'Value Can\'t Be Empty' : null),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                var id = await LoanService().addLoan(
                  Loan(
                    quantity: int.parse(quantityController.text),
                    member: int.parse(memberId!),
                    bookId: int.parse(bookname!),
                  ),
                );
                if (id < 0) {
                  Get.snackbar("ERROR", "OUT OF STOCK");
                }
              },
              child: const Text("Confirm")),
        ],
      ),
    ));
  }

  memeberListWidget() {
    return FutureBuilder<List<Member>>(
      future: MemberService().loadAllMembers(),
      builder: (BuildContext context, AsyncSnapshot<List<Member>> snapshot) {
        Widget children;
        if (snapshot.hasData) {
          children = DropdownButton<String>(
            value: memberId,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            hint: const Text("CHOOSE Member"),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: snapshot.data!.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem<String>(
                alignment: AlignmentDirectional.center,
                value: e.id.toString(),
                child: Text("${e.firstName} ${e.lastName}"),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                memberId = value;
              });
            },
          );
        } else {
          children = const Text('No MEMBERS');
        }
        return children;
      },
    );
  }

  bookListWidget() {
    return FutureBuilder<List<Book>>(
      future: BookService().loadAllBooks(),
      builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
        Widget children;
        if (snapshot.hasData) {
          children = DropdownButton<String>(
            value: bookname,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            hint: const Text("CHOOSE book"),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            items: snapshot.data!.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem<String>(
                alignment: AlignmentDirectional.center,
                value: e.id.toString(),
                child: Text(e.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                bookname = value;
              });
            },
          );
        } else {
          children = const Text('No Books');
        }
        return children;
      },
    );
  }
   
}

