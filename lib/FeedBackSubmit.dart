import 'package:flutter/material.dart';
import 'Loading.dart';

class FeedBackSubmit extends StatefulWidget {
  final String name;
  const FeedBackSubmit(this.name, {Key? key}) : super(key: key);

  @override
  _FeedBackSubmitState createState() => _FeedBackSubmitState();
}

class _FeedBackSubmitState extends State<FeedBackSubmit> {
  @override
  Widget build(BuildContext context) {
    final myControllerFB = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Feedback"),
        backgroundColor: Color.fromARGB(250, 77, 7, 7),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 25, bottom: 25),
                child: TextField(
                  maxLines: 20,
                  controller: myControllerFB,
                  decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                      ),
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(250, 77, 7, 7),
                      ),
                      hintText:
                          'Share your experience...\nYour suggestions are welcome.'),
                ),
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
                  var fb = myControllerFB.text;
                  myControllerFB.text = '';
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Loader(
                              'sendfb', '', '', widget.name, '', '', '', fb)));
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
