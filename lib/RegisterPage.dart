// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Album {
  final String message;

  const Album({required this.message});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      message: json['message'],
    );
  }
}

// Name and Email Controller not set!

Future<Album> createAlbum(String email, String name, String password) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/users'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'job': email,
      'password': password,
    }),
  );
  print("Inga iruken");
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

/*
Future<http.Response> createAlbum(String email, String name, String password) async {
  return http.post(
    Uri.parse('http://127.0.0.1:3000/api/register'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'name': name,
      'password': password,
    }),
  );
}
*/

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
    Future<Album> _futureAlbum;
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
                  color: const Color.fromARGB(133, 78, 6, 6),
                  borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  if (myControllerPass1.text != myControllerPass2.text) {
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
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        });
                  } else {
                    setState(() {
                      _futureAlbum = createAlbum(myControllerEmail.text,
                          myControllerUName.text, myControllerPass1.text);
                    });

                    print("Dei Database la add paniyachu da!");
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
