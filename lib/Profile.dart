import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final user;
  const ProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile Page"),
        backgroundColor: Color.fromARGB(250, 77, 7, 7),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 25),
              child: Center(
                child: Container(
                    width: 350,
                    height: 200,
                    child: Image.asset('assets/Profile.jpeg')),
              ),
            ),
            const Divider(
              thickness: 2,
              indent: 5,
              endIndent: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 25, bottom: 25),
                  child: Row(children: <Widget>[
                    const Text(
                      'Name : ',
                      style: TextStyle(
                          color: Color.fromARGB(133, 78, 6, 6),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.user['name'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ])),
            ),
            const Divider(
              thickness: 2,
              indent: 5,
              endIndent: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 25, bottom: 25),
                  child: Row(children: <Widget>[
                    const Text(
                      'Email : ',
                      style: TextStyle(
                          color: Color.fromARGB(133, 78, 6, 6),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.user['email'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ])),
            ),
            const Divider(
              thickness: 2,
              indent: 5,
              endIndent: 5,
            ),
          ])),
          const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                      'Updating your profile will be available in the future updates.')))
        ],
      ),
    );
  }
}
