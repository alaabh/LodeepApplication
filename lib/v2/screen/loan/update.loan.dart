import 'package:flutter/material.dart';

import 'package:flutter_project/v2/model/loaned_object.model.dart';

import 'package:flutter_project/v2/service/category.service.dart';
import 'package:flutter_project/v2/service/loan.service.dart';
import 'package:get/get.dart';

class UpdateloanPage extends StatefulWidget {
  UpdateloanPage({Key? key}) : super(key: key);

  @override
  _UpdateloanState createState() => _UpdateloanState();
}

class _UpdateloanState extends State<UpdateloanPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  LoanService myservice = LoanService();
  CategoryService categoryService = CategoryService();
  LoanedBook arg = Get.arguments;

  bool _validate = false;
  bool _validatep = false;
  bool _validateu = false;
  bool _validatepa = false;
  String? value;
  String? categoryname;
  DateTime? dateretour;
  String? dropdownValue;

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
      child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  hint: const Text("STATUS"),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  items: [
                    const DropdownMenuItem(
                      value: 'intact',
                      child: Text('intact'),
                    ),
                    const DropdownMenuItem(
                      value: 'damaged',
                      child: Text('damaged'),
                    ),
                    const DropdownMenuItem(
                      value: 'destroyed',
                      child: Text('destroyed'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      DateTime? date = await dateDialog(context);
                      setState(() {
                        dateretour = date;
                      });
                    },
                    child: const Text("Date de retour")),
                ElevatedButton(
                    onPressed: () async {
                      await myservice.updateLoanState(arg.id, arg.bookId,
                          arg.quantity, dropdownValue.toString());
                    },
                    child: const Text("Confirm")),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
