// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'RegisterPage.dart';
import 'HomePage.dart';
import 'ForgotPassword.dart';
import 'Loading.dart';
import 'Storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<String>(
            future: UidStorage.readUid(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != '') {
                  return Loader('homepage', '', '', snapshot.data.toString(),
                      '', '', '', '');
                } else {
                  return const LoginDemo();
                }
              } else {
                return const LoginDemo();
              }
            }));
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final myControllerEmail = TextEditingController();
  final myControllerPass = TextEditingController();

  @override
  void dispose() {
    myControllerEmail.dispose();
    myControllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: Color.fromARGB(250, 77, 7, 7),
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
                    child: Image.asset('assets/Notepad.jpg')),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: myControllerEmail,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(250, 77, 7, 7),
                    ),
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: myControllerPass,
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
                    hintText: 'Enter password'),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ForgotPass()));
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                    color: Color.fromARGB(133, 78, 6, 6), fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(250, 77, 7, 7),
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  if (myControllerEmail.text == '' ||
                      myControllerPass.text == '') {
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
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Loader(
                                'login',
                                myControllerEmail.text,
                                myControllerPass.text,
                                '',
                                '',
                                '',
                                '',
                                '')),
                        (route) => false);
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: const Text(
                'New User? Register here',
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
