// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Loading.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final myControllerEmail = TextEditingController();
  final myControllerUName = TextEditingController();
  final myControllerPass1 = TextEditingController();
  final myControllerPass2 = TextEditingController();

  @override
  void dispose() {
    myControllerEmail.dispose();
    myControllerUName.dispose();
    myControllerPass1.dispose();
    myControllerPass2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
        backgroundColor: const Color.fromARGB(250, 77, 7, 7),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/Register.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: myControllerEmail,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Color.fromARGB(250, 77, 7, 7),
                    ),
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: myControllerUName,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                    ),
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(250, 77, 7, 7),
                    ),
                    hintText: 'Enter Your name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: myControllerPass1,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(250, 77, 7, 7),
                    ),
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: myControllerPass2,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                    ),
                    labelText: 'Re-enter Password',
                    labelStyle: TextStyle(color: Color.fromARGB(250, 77, 7, 7)),
                    hintText: 'Enter password again'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              margin: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(250, 77, 7, 7),
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  if (myControllerEmail.text == '' ||
                      myControllerUName.text == '' ||
                      myControllerPass1.text == '' ||
                      myControllerPass2.text == '') {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: SingleChildScrollView(
                                child: ListBody(
                              children: const <Widget>[
                                Text('Enter all the fields'),
                              ],
                            )),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text('OK',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(250, 77, 7, 7))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  } else if (myControllerPass1.text != myControllerPass2.text) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: SingleChildScrollView(
                                child: ListBody(
                              children: const <Widget>[
                                Text('Password Mismatch'),
                              ],
                            )),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text('OK',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(250, 77, 7, 7))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Loader(
                                'register',
                                myControllerEmail.text,
                                myControllerPass1.text,
                                myControllerUName.text,
                                '',
                                '',
                                '',
                                '')),
                        (route) => false);
                  }
                },
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
