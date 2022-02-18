import 'package:deardiary/HomePage.dart';
import 'package:deardiary/SetPassword.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Loader extends StatefulWidget {
  final String action;
  final String email;
  final String pass;
  final String name;
  final String otp;

  const Loader(this.action, this.email, this.pass, this.name, this.otp);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool _loading = false;
  Widget nextPage = MyApp();
  String loadMsg = 'Loading...';
  final String baseURL = 'https://immense-fortress-65428.herokuapp.com/api';
  @override
  void initState() {
    super.initState();
    if (widget.action == 'login') {
      methodLogin(widget.email, widget.pass);
    } else if (widget.action == 'register') {
      methodRegister(widget.email, widget.pass, widget.name);
    } else if (widget.action == 'getotp') {
      methodGetOtp(widget.email);
    } else if (widget.action == 'setpass') {
      methodSetPass(widget.email, widget.pass, widget.otp);
    }
  }

  Future<void> methodLogin(String email, String password) async {
    setState(() {
      _loading = true;
      loadMsg = "We are looking our diary for your account...";
    });

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(baseURL + '/login'));
    request.bodyFields = {'email': email, 'password': password};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // ignore: non_constant_identifier_names
    var Sresponse = await http.Response.fromStream(response);
    final result = jsonDecode(Sresponse.body) as Map<String, dynamic>;
    print(result);
    setState(() {
      _loading = false;
      nextPage = HomePage();
    });
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> methodRegister(
      String email, String password, String name) async {
    setState(() {
      _loading = true;
      loadMsg = "Hold on! Your account is being added to our diary...";
    });
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(baseURL + '/register'));
    request.bodyFields = {'email': email, 'password': password, 'name': name};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // ignore: non_constant_identifier_names
    var Sresponse = await http.Response.fromStream(response);
    final result = jsonDecode(Sresponse.body) as Map<String, dynamic>;
    print(result['message']);
    setState(() {
      _loading = false;
      nextPage = MyApp();
    });
    Fluttertoast.showToast(msg: 'User Created Successfully');
    // var snackBar = const SnackBar(content: Text('User Registered Successfully'));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> methodGetOtp(String email) async {
    setState(() {
      _loading = true;
      loadMsg = "Sending One Time Key to your email...";
    });
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(baseURL + '/getotp'));
    request.bodyFields = {'email': email};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // ignore: non_constant_identifier_names
    var Sresponse = await http.Response.fromStream(response);
    final result = jsonDecode(Sresponse.body) as Map<String, dynamic>;
    print(result['message']);
    setState(() {
      _loading = false;
      nextPage = SetPass(email: email);
    });
  }

  Future<void> methodSetPass(String email, String password, String otp) async {
    setState(() {
      _loading = true;
      loadMsg = "Updating Your password...";
    });
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(baseURL + '/setpassword'));
    request.bodyFields = {'email': email, 'password': password, 'otp': otp};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // ignore: non_constant_identifier_names
    var Sresponse = await http.Response.fromStream(response);
    final result = jsonDecode(Sresponse.body) as Map<String, dynamic>;
    print(result['message']);
    setState(() {
      _loading = false;
      nextPage = MyApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      // Alignment not centered!!!
      return MaterialApp(
          home: Scaffold(
              body: SingleChildScrollView(
                  child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Center(
            child: SizedBox(
                width: 320,
                height: 250,
                child: Image.asset('assets/Loading.gif')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 70, bottom: 0),
          child: Text(
            loadMsg,
            style: const TextStyle(
              color: Color.fromARGB(250, 77, 7, 7),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ]))));
    } else {
      return nextPage;
    }
  }
}

// Center(
//                   child: CircularProgressIndicator(
//                   color: Color.fromARGB(250, 77, 7, 7), 
//                   )
//                 ),