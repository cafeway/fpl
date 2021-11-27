// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';

TextEditingController opponent = TextEditingController();
TextEditingController matchday = TextEditingController();
TextEditingController  results = TextEditingController();
TextEditingController teamTitle = TextEditingController();
class EventsPage extends StatefulWidget {
  const EventsPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  int _counter = 0;
  bool _authenticated = false;

  // text editing controllers

  void _increment() {
    setState(() {
      _counter++;
      print('$_counter');
    });
  }
  @override
  void dispose(){

    opponent.dispose();
                matchday.dispose();
                results.dispose();
                super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final TeamName = ModalRoute.of(context)!.settings.arguments;
     teamTitle.text = TeamName.toString();
    final Stream = FirebaseFirestore.instance.collection('events').where('team',isEqualTo: TeamName).snapshots();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    // ignore: unnecessary_null_comparison
    if (user != null && user.emailVerified) {
      print(user);
      Navigator.pushNamed(context, '/login');
    } else {
      // print('no user');
    }

    //  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     setState(() {
    //       _authenticated = false;
    //     });
    //   } else {
    //     setState(() {
    //       _authenticated = true;
    //     });
    //   }
    // });
    // if (_authenticated != true){
    //   Navigator.pushNamed(context, '/login');
    // }
    const themecolor = Colors.blueAccent;
    Padding(padding: EdgeInsets.all(20.0));
    return StreamBuilder(
        stream: Stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("upcoming events"),
                centerTitle: true,
                actions: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Icon(
                        Icons.supervised_user_circle,
                        size: 40.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              body: Center(
                child: Text("something went wrong"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text("upcoming events"),
                centerTitle: true,
                actions: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Icon(
                        Icons.supervised_user_circle,
                        size: 40.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            );
          }
          return Scaffold(
            drawer: Drawer(
              child: Center(
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: themecolor,
                      ),
                      child: Text("Hello"),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      dense: true,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(80),
                      //   side: BorderSide(color: Colors.black)
                      //   ),
                      leading: Icon(
                        Icons.brush,
                        color: themecolor,
                      ),
                      trailing: Switch(
                        onChanged: (bool value) {
                          // change theme
                        },
                        value: false,
                      ),
                      title: const Text(
                        "Theme",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      endIndent: 4.0,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leading: const Icon(
                        Icons.language,
                        color: themecolor,
                      ),
                      title: Text(
                        "Choose Language",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      endIndent: 4.0,
                    ),
                    SizedBox(
                      height: 250,
                    ),
                    ListTile(
                        leading: FloatingActionButton(
                          onPressed: () {
                            auth.signOut();
                            Navigator.pushNamed(context, '/login');
                          },
                          backgroundColor: themecolor,
                          child: Icon(Icons.logout),
                        ),
                        title: Text(
                          "logout",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              // actions
              actions: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Icon(
                      Icons.supervised_user_circle,
                      size: 40.0,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
              ],

              // Title
              centerTitle: true,
              title: Title(
                color: Colors.black,
                child: Text("$TeamName Upcoming Events"),
              ),
            ),
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Icon(
                  Icons.bolt,
                  size: 50.0,
                  color: Colors.green,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Events",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DataTable(
                  columns: [
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("event")),
                    DataColumn(label: Text("time"))
                   
                  ],
                  rows: _buildList(context, snapshot.data!.docs),
                ),
              ],
            ),

            // bottom Floating Action Button
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => _addteam(context));
              },
              tooltip: 'Share',
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}

// alert dialog to add a team to the league
Widget _addteam(BuildContext context) {
  // ignore: unnecessary_new
  return new AlertDialog(
    title: Text("Add Event"),
    content: ListView(
  
    
      children: [
        TextField(
          controller: opponent,
          decoration:
              InputDecoration( hintText: 'Date e.g 10/10/2021'),
        ),
        TextField(
          controller: matchday,
          maxLines: 2,
          decoration:
              InputDecoration( hintText: 'event'),
        ),
        TextField(
          controller: results,
          decoration:
              InputDecoration( hintText: 'time'),
        ),
         
      ],
    ),
    actions: [
      FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('fpl_users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot snapshot){
              FirebaseFirestore.instance
                    .collection("events")
                    .add({'opponent': opponent.text, 'matchday': matchday.text,'results':results.text,'team':teamTitle.text});
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("event added successfully")));
                Navigator.of(context).pop();
                
          });
        },
        child: Icon(Icons.add),
      )
    ],
  );
}

List<DataRow> _buildList(
    BuildContext context, List<DocumentSnapshot> snapshot) {
  return snapshot.map((data) => _buildItems(context, data)).toList();
}

DataRow _buildItems(BuildContext context, DocumentSnapshot data) {
  return DataRow(
    cells: [
      DataCell(Text(data['opponent']), onTap: () {
        Navigator.pushNamed(context, '/TeamStats', arguments: data['Name']);
      }),
      DataCell(
        Text(
          data['matchday'],
        ),
        placeholder: true,
      ),
      DataCell(
        Text(
          data['results'],
        ),
        placeholder: true,
      ),
    ],
  );
}

