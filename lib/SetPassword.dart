// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'Loading.dart';

class SetPass extends StatefulWidget {
  final String email;
  // ignore: use_key_in_widget_constructors
  const SetPass({required this.email});

  @override
  _SetPassState createState() => _SetPassState();
}

class _SetPassState extends State<SetPass> {
  final myControllerOtp = TextEditingController();
  final myControllerPass1 = TextEditingController();
  final myControllerPass2 = TextEditingController();

  @override
  void dispose() {
    myControllerOtp.dispose();
    myControllerPass1.dispose();
    myControllerPass2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter OTP'),
        backgroundColor: const Color.fromARGB(250, 77, 7, 7),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/FPass.png')),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextFormField(
              initialValue: widget.email,
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                ),
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextField(
              controller: myControllerOtp,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                  ),
                  labelText: 'One-Time Pasword',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(250, 77, 7, 7),
                  ),
                  hintText: 'Enter the OTP sent to your mail'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextField(
              obscureText: true,
              controller: myControllerPass1,
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
                  hintText: 'Enter the new password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextField(
              obscureText: true,
              controller: myControllerPass2,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                  ),
                  labelText: 'Confirm password',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(250, 77, 7, 7),
                  ),
                  hintText: 'Re-enter the new password'),
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
                if (myControllerPass1.text == '' ||
                    myControllerPass2.text == '' ||
                    myControllerOtp.text == '') {
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
                                        color: Color.fromARGB(250, 77, 7, 7))),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                } else if (myControllerPass1.text == myControllerPass2.text) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Loader(
                          'setpass',
                          widget.email,
                          myControllerPass1.text,
                          '',
                          myControllerOtp.text),
                    ),
                    (route) => false,
                  );
                } else {
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
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Color.fromARGB(250, 77, 7, 7),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 40.0, bottom: 5.0),
            child: Text(
                'Check your spam emails, if you have not received the OTP'),
          )
        ]),
      ),
    );
  }
}
