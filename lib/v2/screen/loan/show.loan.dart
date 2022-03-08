import 'package:flutter/material.dart';
import 'package:flutter_project/v2/model/loaned_object.model.dart';
import 'package:flutter_project/v2/screen/book/add.book.dart';
import 'package:flutter_project/v2/screen/loan/update.loan.dart';
import 'package:flutter_project/v2/service/loan.service.dart';

import 'package:get/get.dart';

class LoansListPage extends StatefulWidget {
  LoansListPage({Key? key}) : super(key: key);

  @override
  _LoansListState createState() => _LoansListState();
}

class _LoansListState extends State<LoansListPage> {
  LoanService myservice = LoanService();
  AddBookPage addbook = AddBookPage();

  TextEditingController quantityController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<LoanedBook>>(
          future: myservice.loadAllLoansDetails(),
          builder: (BuildContext context,
              AsyncSnapshot<List<LoanedBook>> snapshot) {
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
                          InkWell(
                            onTap: () {
                              Get.to(UpdateloanPage(),
                                  arguments: snapshot.data![index]);
                            },
                            child: ListTile(
                              leading: const Icon(Icons.album, size: 30),
                              title: FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                        snapshot.data![index].quantity
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(snapshot.data![index].name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${snapshot.data![index].firstName} ${snapshot.data![index].lastName} ",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      snapshot.data![index].number
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      snapshot.data![index].cinNumber
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
