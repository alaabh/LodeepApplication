import 'package:flutter/material.dart';

import 'package:flutter_project/v2/model/book.model.dart';
import 'package:flutter_project/v2/model/category.model.dart';

import 'package:flutter_project/v2/service/Book.service.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project/v2/service/category.service.dart';


class AddBookPage extends StatefulWidget {
  AddBookPage({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBookPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  BookService myservice = BookService();
  CategoryService categoryService = CategoryService();

  bool _validate = false;
  bool _validatep = false;
  bool _validateu = false;
  bool _validatepa = false;
  String? value;
  String? categoryname;
  DateTime? dateacq;

  static Future<DateTime?> dateDialog(BuildContext context) {
    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          confirmText: "Procced",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<Category>>(
          future: categoryService.loadAllCategories(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            Widget children;
            if (snapshot.hasData) {
              children = DropdownButton<String>(
                value: categoryname,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                hint: const Text("CHOOSE CATEGORY"),
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
                  print("CATEGORY NAME = $categoryname");
                  setState(() {
                    categoryname = value;
                  });
                },
              );
            } else {
              children = const Text('No CATEGORY');
            }
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 120,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'book Name',
                            errorText:
                                _validate ? 'Value Can\'t Be Empty' : null),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: quantityController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'quantity',
                            errorText:
                                _validate ? 'Value Can\'t Be Empty' : null),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          DateTime? date = await dateDialog(context);
                          setState(() {
                            dateacq = date;
                          });
                        },
                        child: const Text("Date d'acquition")),
                    children,
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await myservice.addBook(Book(
                              name: nameController.text,
                              addedAt: DateFormat('yyyy-MM-dd ')
                                  .format(dateacq!)
                                  .toString(),
                              quantity: int.parse(quantityController.text),
                              category: int.parse(categoryname!)));
                        },
                        child: const Text("Confirm")),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
