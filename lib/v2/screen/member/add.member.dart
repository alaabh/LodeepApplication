import 'package:flutter/material.dart';

import 'package:flutter_project/v2/model/member.model.dart';

import 'package:flutter_project/v2/service/member.service.dart';

class AddMemberPage extends StatefulWidget {
  AddMemberPage({Key? key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMemberPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController cinnumberController = TextEditingController();

  MemberService myservice = MemberService();

  bool _validate = false;
  bool _validatep = false;
  bool _validateu = false;
  bool _validatepa = false;
  String? value;
  String? categoryname;
  DateTime? dateacq;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
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
                    controller: firstnameController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'firstname Name',
                        errorText: _validate ? 'Value Can\'t Be Empty' : null),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: lastnameController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'lastname',
                        errorText: _validate ? 'Value Can\'t Be Empty' : null),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: numberController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'number',
                        errorText: _validate ? 'Value Can\'t Be Empty' : null),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: cinnumberController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'NumCin',
                        errorText: _validate ? 'Value Can\'t Be Empty' : null),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await myservice.addMember(Member(
                        firstName: firstnameController.text,
                        lastName: lastnameController.text,
                        number: int.parse(numberController.text),
                        cinNumber: int.parse(cinnumberController.text),
                      ));
                    },
                    child: const Text("Confirm")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
