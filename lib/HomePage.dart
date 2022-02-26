// ignore_for_file: deprecated_member_use

import 'package:deardiary/FeedBackSubmit.dart';
import 'package:deardiary/Loading.dart';
import 'package:deardiary/main.dart';
import 'package:deardiary/ShowMemory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Profile.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final memories;
  final user;
  const HomePage(this.user, this.memories, {Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String formatter;
  late DateTime currentDate;
  late DateTime searchD;
  late int page;
  late TextEditingController dateInput;
  late TextEditingController titleInput;
  late TextEditingController contentInput;

  @override
  void initState() {
    formatter = DateFormat.yMMMEd().format(DateTime.now());
    currentDate = DateTime.now();
    searchD = DateTime.now();
    page = 0;
    dateInput = TextEditingController(text: formatter);
    titleInput = TextEditingController();
    contentInput = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dateInput.dispose();
    super.dispose();
  }

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
    return searchList;
  }

  Widget addMemory(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: IconButton(
                iconSize: 20,
                onPressed: () {
                  if (page == 1) {
                    setState(() {
                      page = 0;
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
                onPressed: () {
                  setState(() {});
                },
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
                      page = 2;
                    });
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
        SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            child: TextFormField(
              focusNode: AlwaysDisabledFocusNode(),
              controller: dateInput,
              onTap: () async {
                if (await _selectDate(context)) {
                  setState(() {
                    dateInput.text = DateFormat.yMMMEd().format(searchD);
                  });
                }
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    if (await _selectDate(context)) {
                      setState(() {
                        dateInput.text = DateFormat.yMMMEd().format(searchD);
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today,
                      color: Color.fromARGB(250, 77, 7, 7)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                ),
                labelText: "Date",
                labelStyle: const TextStyle(
                  color: Color.fromARGB(250, 77, 7, 7),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 25, bottom: 0),
            child: TextField(
              controller: titleInput,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        BorderSide(color: Color.fromARGB(250, 77, 7, 7)),
                  ),
                  labelText: 'Title',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(250, 77, 7, 7),
                  ),
                  hintText: 'Give your memory a title'),
            ),
          ),
          Container(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 25, bottom: 0),
              child: TextField(
                maxLines: 10,
                controller: contentInput,
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
                    hintText: 'Drop down your memory here...'),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            margin: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 25, bottom: 0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(250, 77, 7, 7),
                borderRadius: BorderRadius.circular(20)),
            child: FlatButton(
              onPressed: () {
                if (titleInput.text == '' || contentInput.text == '') {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Create a Wholesome memory'),
                          content: SingleChildScrollView(
                              child: ListBody(
                            children: const <Widget>[
                              Text(
                                  'Enter both the title and the description to define your memory.'),
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
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Loader(
                                'addmemory',
                                '',
                                '',
                                '',
                                '',
                                dateInput.text,
                                titleInput.text,
                                contentInput.text,
                              )));
                }
              },
              child: const Text(
                'Add to my Diary',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ]))
      ],
    );
  }

  Widget buildPage(BuildContext context) {
    switch (page) {
      case 0:
        {
          return getList(sortMemories(widget.memories));
        }
      case 1:
        {
          return addMemory(context);
        }
      case 2:
        {
          return getList(searchDate(widget.memories, searchD));
        }
      default:
        return getList(sortMemories(widget.memories));
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
                iconSize: 20,
                onPressed: () {
                  if (page == 2) {
                    setState(() {
                      page = 0;
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
                onPressed: () {
                  setState(() {
                    // dateInput.text = DateFormat.yMMMEd().format(DateTime.now());
                    page = 1;
                  });
                },
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
                      page = 2;
                    });
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
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ShowMem(
                                              mems[index]["date"].toString(),
                                              mems[index]["title"].toString(),
                                              mems[index]["content"]
                                                  .toString())));
                                },
                              )))
                      : const CircularProgressIndicator(),
                )))
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
      drawer: NavDrawer(widget.user),
      resizeToAvoidBottomInset: false,
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
                padding: const EdgeInsets.only(top: 20, right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(formatter,
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                )),
          ]),
      body: buildPage(context),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final user;
  const NavDrawer(this.user, {Key? key}) : super(key: key);

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
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ProfilePage(user)))
            },
          ),
          ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Feedback'),
              onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FeedBackSubmit(user['name'])))
                  }),
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
