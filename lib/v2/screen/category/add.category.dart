import 'package:flutter/material.dart';

import 'package:flutter_project/v2/model/category.model.dart';


import 'package:flutter_project/v2/service/category.service.dart';


class AddCategoryPage extends StatefulWidget {
  AddCategoryPage({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategoryPage> {
  TextEditingController nameController = TextEditingController();
  
  CategoryService myservice = CategoryService();
  bool _validate = false;
  bool _validatep = false;
  bool _validateu = false;
  bool _validatepa = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Category Name',
                          errorText:
                              _validate ? 'Value Can\'t Be Empty' : null),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: const Text('Add'),
                    onPressed: () async {
                      nameController.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      await myservice
                          .addCategory(Category(name: nameController.text));
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
