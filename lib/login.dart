import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'dashbord.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _validate = false;
  bool _validatep = false;
  bool _validateu = false;
  bool _validatepa = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // ignore: undefined_prefixed_name

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Center(
                child: SizedBox(
                  width: 200,
                  child: Text(
                    'Sign in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'User Name',
                    errorText: _validate
                        ? 'Value Can\'t Be Empty'
                        : _validateu
                            ? 'incorect username'
                            : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    errorText: _validatep
                        ? 'Value Can\'t Be Empty'
                        : _validatepa
                            ? 'incorect password'
                            : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                child: const Text('Login'),
                onPressed: () {
                  setState(() {
                    nameController.text.isEmpty
                        ? _validate = true
                        : _validate = false;

                    passwordController.text.isEmpty
                        ? _validatep = true
                        : _validatep = false;
                    if (nameController.text != 'admin' ||
                        passwordController.text != 'admin') {
                      _validateu = true;
                      _validatepa = true;
                    } else {
                      Get.to(const HomePage());
                    }
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
