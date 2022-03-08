import 'package:flutter/material.dart';

import 'package:flutter_project/v2/model/member.model.dart';

import 'package:flutter_project/v2/screen/member/add.member.dart';

import 'package:flutter_project/v2/service/member.service.dart';

import 'package:get/get.dart';

class MembesrsListPage extends StatefulWidget {
  MembesrsListPage({Key? key}) : super(key: key);

  @override
  _MembesrsListState createState() => _MembesrsListState();
}

class _MembesrsListState extends State<MembesrsListPage> {
  MemberService myservice = MemberService();
  AddMemberPage addmember = AddMemberPage();

  TextEditingController quantityController = TextEditingController();
  final bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          Get.to(addmember);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: FutureBuilder<List<Member>>(
          future: myservice.loadAllMembers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Member>> snapshot) {
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
                              leading:
                                  const Icon(Icons.accessibility_new, size: 48),
                              title: FittedBox(
                                child: Row(
                                  children: [
                                    Text(snapshot.data![index].firstName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(snapshot.data![index].lastName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                        snapshot.data![index].number
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                        snapshot.data![index].cinNumber
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
