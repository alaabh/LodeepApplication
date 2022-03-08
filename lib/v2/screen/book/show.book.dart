import 'package:flutter/material.dart';
import 'package:flutter_project/v2/model/book.model.dart';

import 'package:flutter_project/v2/screen/book/add.book.dart';

import 'package:flutter_project/v2/service/Book.service.dart';


import 'package:get/get.dart';

class BooksListPage extends StatefulWidget {
  BooksListPage({Key? key}) : super(key: key);

  @override
  _BooksListState createState() => _BooksListState();
}

class _BooksListState extends State<BooksListPage> {
  BookService myservice = BookService();
  AddBookPage addbook = AddBookPage();

  TextEditingController quantityController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          Get.to(addbook);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: FutureBuilder<List<Book>>(
          future: myservice.loadAllBooks(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
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
                              leading: const Icon(Icons.computer, size: 48),
                              trailing: InkWell(
                                child: const Icon(Icons.edit, size: 20),
                                onTap: () {
                                  Get.defaultDialog(
                                      title: "Update quantity",
                                      content: TextField(
                                        controller: quantityController,
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            labelText: 'Update quantity',
                                            errorText: _validate
                                                ? 'Value Can\'t Be Empty'
                                                : null),
                                      ),
                                      textConfirm: "ADD",
                                      textCancel: "CANCEL",
                                      onConfirm: () async {
                                        quantityController.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        await myservice.updateQuantity(
                                            snapshot.data![index].id!,
                                            int.parse(quantityController.text) +
                                                snapshot.data![index].quantity);
                                        Get.back();
                                        setState(() {});
                                      });
                                },
                              ),
                              title: FittedBox(
                                child: Row(
                                  children: [
                                    Text("name:" + snapshot.data![index].name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        snapshot.data![index].quantity
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        "AdedAt: " +
                                            snapshot.data![index].addedAt
                                                .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
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
