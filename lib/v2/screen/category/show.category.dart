import 'package:flutter/material.dart';
import 'package:flutter_project/v2/model/category.model.dart';
import 'package:flutter_project/v2/screen/category/add.category.dart';
import 'package:flutter_project/v2/service/category.service.dart';

import 'package:get/get.dart';

class CategoriesListPage extends StatefulWidget {
  CategoriesListPage({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesListPage> {
  CategoryService listCategories = CategoryService();
  AddCategoryPage addcategory = AddCategoryPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(
                      backgroundColor: const Color(0xff03dac6),
                      foregroundColor: Colors.black,
                      onPressed: () {
                        Get.to(addcategory);
                      },
                      child: Icon(Icons.add),
                    ),
      body: Container(
        child: FutureBuilder<List<Category>>(
          future: listCategories.loadAllCategories(),
          builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            if (!snapshot.hasData) {
              return Text("NO DATA");
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Card(
                        elevation: 8,
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.album, size: 48),
                              title: Text(snapshot.data![index].name,
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
        
      ),
     
    );
  }
}
