import 'package:flutter/material.dart';

class ShowMem extends StatefulWidget {
  final String date;
  final String title;
  final String content;
  const ShowMem(this.date, this.title, this.content, {Key? key})
      : super(key: key);

  @override
  _ShowMemState createState() => _ShowMemState();
}

class _ShowMemState extends State<ShowMem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(250, 77, 7, 7),
        body: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // color: Color.fromARGB(133, 126, 89, 89),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(widget.title,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(widget.date),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(133, 78, 6, 6),
                      indent: 10,
                      endIndent: 10,
                      thickness: 2,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 10, top: 15),
                            child: Text('\t\t\t\t\t\t\t\t\t\t' + widget.content,
                                style: const TextStyle(
                                    fontSize: 16, letterSpacing: 1.1))),
                      ),
                    )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        width: 250,
                        margin: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(250, 77, 7, 7),
                            borderRadius: BorderRadius.circular(20)),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    )
                  ])),
            )));
  }
}
