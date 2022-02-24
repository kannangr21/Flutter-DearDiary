// ignore_for_file: deprecated_member_use

import 'package:deardiary/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final memories;

  const HomePage(this.memories, {Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String formatter = DateFormat.yMMMEd().format(DateTime.now());
  DateTime currentDate = DateTime.now();
  DateTime searchD = DateTime.now();
  int page = 1;

  List sortMemories(List mems) {
    List sortedList = mems;
    sortedList.sort(((a, b) {
      DateTime date1 = DateFormat('EEE, MMM d, yyyy').parse(a['date']);
      DateTime date2 = DateFormat('EEE, MMM d, yyyy').parse(b['date']);
      return date2.compareTo(date1);
    }));
    return sortedList;
  }

  List searchDate(List mems, DateTime date) {
    List searchList = [];
    String dateSearch = DateFormat.yMMMEd().format(date);
    var dateSe = DateFormat('EEE, MMM d, yyyy').parse(dateSearch);
    for (var mem in mems) {
      var dateMem = DateFormat('EEE, MMM d, yyyy').parse(mem['date']);
      if (dateSe.compareTo(dateMem) == 0) {
        searchList.add(mem);
      }
    }
    print(searchList);
    return searchList;
  }

  Widget buildPage(BuildContext context) {
    switch (page) {
      case 0:
        {
          return getList(searchDate(widget.memories, searchD));
        }
      default:
        {
          return getList(sortMemories(widget.memories));
        }
    }
  }

  Widget getList(List mems) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: IconButton(
                onPressed: () {
                  if (page == 0) {
                    setState(() {
                      page = 1;
                    });
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: FlatButton(
                onPressed: () {},
                child: Text('+ Add Memory'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: FlatButton(
                onPressed: () async {
                  if (await _selectDate(context)) {
                    /* Searching part Goes here*/
                    setState(() {
                      page = 0;
                    });
                    print(currentDate);
                  }
                },
                child: Text('Search by Date'),
              ),
            )
          ],
        ),
        const Divider(
          thickness: 2,
          indent: 5,
          endIndent: 5,
        ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 6.0, right: 6.0),
                child: ListView.builder(
                  itemCount: mems.length,
                  itemBuilder: (context, index) => mems.isNotEmpty
                      ? SizedBox(
                          height: 120,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color.fromARGB(133, 78, 6, 6),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(
                                    top: 10.0,
                                    right: 7.0,
                                    left: 5.0,
                                    bottom: 10.0),
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(mems[index]["date"]
                                        .toString()
                                        .split(',')[1]),
                                    const VerticalDivider(
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                                title: Padding(
                                    padding:
                                        EdgeInsets.only(top: 12.0, bottom: 4.0),
                                    child: Text(
                                      mems[index]["title"].toString(),
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                subtitle: Text(
                                  mems[index]["content"].toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {},
                              )))
                      : const CircularProgressIndicator(),
                )))
        // SizedBox(
        //     height: 500,
        //     child: Card(
        //         shape: RoundedRectangleBorder(
        //           side: BorderSide(
        //             color: Colors.green.shade300,
        //           ),
        //           borderRadius: BorderRadius.circular(15.0),
        //         ),
        //         child: const ListTile(
        //           title: Text("Title"),
        //           subtitle: Text("This is a Subtitle"),
        //         ))),
        // SizedBox(
        //     height: 500,
        //     child: Card(
        //         shape: RoundedRectangleBorder(
        //           side: BorderSide(
        //             color: Colors.green.shade300,
        //           ),
        //           borderRadius: BorderRadius.circular(15.0),
        //         ),
        //         child: const ListTile(
        //           title: Text("Title"),
        //           subtitle: Text("This is a Subtitle"),
        //       )
        //     )
        //   ),
      ],
    );
  }

  Future<bool> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(250, 77, 7, 7), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Color.fromARGB(133, 78, 6, 6), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary:
                    const Color.fromARGB(250, 77, 7, 7), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        searchD = pickedDate;
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
          title: const Text('My Diary'),
          backgroundColor: const Color.fromARGB(250, 77, 7, 7),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.account_circle_outlined,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {},
                    child: FlatButton(
                      onPressed: () {
                        print(formatter);
                      },
                      child: Text(formatter,
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                    ))),
          ]),
      body: buildPage(context),
    );
  }
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('assets/Diary.jpeg'))),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_sharp),
            title: Text('Profile'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (_) => MyApp()), (route) => false)
            },
          ),
        ],
      ),
    );
  }
}
