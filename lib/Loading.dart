import 'package:deardiary/FeedBackSubmit.dart';
import 'package:deardiary/HomePage.dart';
import 'package:deardiary/SetPassword.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'Storage.dart';

class Loader extends StatefulWidget {
  final String action;
  final String email;
  final String pass;
  final String name;
  final String otp;
  final String date;
  final String title;
  final String content;

  Loader(this.action, this.email, this.pass, this.name, this.otp, this.date,
      this.title, this.content);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  late FToast fToast;
  late bool _loading;
  late Widget nextPage;
  late String loadMsg;
  late String toastMsg;
  late final String baseURL;
  static String uid = '';

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _loading = false;
    nextPage = MyApp();
    loadMsg = 'Loading...';
    toastMsg = '';
    baseURL = 'https://fierce-badlands-19146.herokuapp.com/api';
    if (widget.action == 'login') {
      methodLogin(widget.email, widget.pass);
    } else if (widget.action == 'register') {
      methodRegister(widget.email, widget.pass, widget.name);
    } else if (widget.action == 'getotp') {
      methodGetOtp(widget.email);
    } else if (widget.action == 'setpass') {
      methodSetPass(widget.email, widget.pass, widget.otp);
    } else if (widget.action == 'addmemory') {
      methodAddMem(uid, widget.date, widget.title, widget.content);
    } else if (widget.action == 'sendfb') {
      methodSendFb(widget.name, widget.content);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black,
      ),
      child: Text(toastMsg,
          style: const TextStyle(
            color: Colors.white,
          )),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
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

    setState(() {
      if (result['success']) {
        _loading = false;
        uid = result['user']['userId'];
        UidStorage.writeUid(uid);

        nextPage = HomePage(result['user'], result['memories'] as List);
      } else {
        _loading = false;
        toastMsg = result['message'];
        _showToast();
        nextPage = const MyApp();
      }
    });
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

    setState(() {
      if (result['success']) {
        _loading = false;
        nextPage = MyApp();
        toastMsg = 'Account Registered Successfully!';
      } else {
        _loading = false;
        toastMsg = result['message'];
        nextPage = const MyApp();
      }
    });
    _showToast();
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

    setState(() {
      if (result['success']) {
        _loading = false;
        nextPage = SetPass(email: email);
        toastMsg = "OTP has been sent to your email.";
      } else {
        _loading = false;
        toastMsg = result['message'];
        nextPage = const MyApp();
      }
    });
    _showToast();
  }

  Future<void> methodSetPass(String email, String password, String otp) async {
    setState(() {
      _loading = true;
      loadMsg = "Rewriting your password...";
    });
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(baseURL + '/setpassword'));
    request.bodyFields = {'email': email, 'password': password, 'otp': otp};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // ignore: non_constant_identifier_names
    var Sresponse = await http.Response.fromStream(response);
    final result = jsonDecode(Sresponse.body) as Map<String, dynamic>;

    setState(() {
      if (result['success']) {
        _loading = false;
        nextPage = MyApp();
        toastMsg = "Your password has been changed.";
      } else {
        _loading = false;
        toastMsg = result['message'];
        nextPage = const MyApp();
      }
    });
    _showToast();
  }

  Future<void> methodAddMem(
      String uid, String date, String title, String content) async {
    setState(() {
      _loading = true;
      loadMsg = "Writing in your diary...";
    });
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(baseURL + '/memory/create'));
    request.bodyFields = {
      'uuid': uid,
      'date': date,
      'title': title,
      'content': content
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // ignore: non_constant_identifier_names
    var Sresponse = await http.Response.fromStream(response);
    final result = jsonDecode(Sresponse.body) as Map<String, dynamic>;

    setState(() {
      if (result['success']) {
        _loading = false;
        getHomePage(uid);
        nextPage = MyApp();
      } else {
        _loading = false;
        toastMsg = result['message'];
        _showToast();
        nextPage = const MyApp();
      }
    });
  }

  Future<void> getHomePage(String uid) async {
    setState(() {
      _loading = true;
      loadMsg = "Writing in your diary...\nThis may take few seconds.";
    });
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('GET', Uri.parse(baseURL + '/homepage'));
    request.bodyFields = {
      'uuid': uid,
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // ignore: non_constant_identifier_names
    var Sresponse = await http.Response.fromStream(response);
    final result = jsonDecode(Sresponse.body) as Map<String, dynamic>;

    setState(() {
      if (result['success']) {
        _loading = false;
        nextPage = HomePage(result['user'], result['memories'] as List);
        toastMsg = "Written in your Diary";
      } else {
        _loading = false;
        toastMsg = result['message'];
        nextPage = const MyApp();
      }
    });
    _showToast();
  }

  Future<void> methodSendFb(String name, String feedback) async {
    setState(() {
      _loading = true;
      loadMsg = "Sending your feedback...";
    });
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(baseURL + '/feedback'));
    request.bodyFields = {'name': name, 'feedback': feedback};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // ignore: non_constant_identifier_names
    var Sresponse = await http.Response.fromStream(response);
    final result = jsonDecode(Sresponse.body) as Map<String, dynamic>;

    setState(() {
      if (result['success']) {
        _loading = false;
        nextPage = FeedBackSubmit(name);
        toastMsg =
            "We have received your feedback.\nThanks for submitting your feedback.";
      } else {
        _loading = false;
        toastMsg = result['message'];
        nextPage = const MyApp();
      }
    });
    _showToast();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      // Alignment not centered!!!
      return MaterialApp(
          debugShowCheckedModeBanner: false,
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