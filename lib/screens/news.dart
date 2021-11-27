// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';

TextEditingController teamname = TextEditingController();
TextEditingController points = TextEditingController();
TextEditingController _updatepoints = TextEditingController();
TextEditingController teamTitle = TextEditingController();
class NewsPage extends StatefulWidget {
  const NewsPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

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
  Widget build(BuildContext context) {
     final TeamName = ModalRoute.of(context)!.settings.arguments;
     teamTitle.text = TeamName.toString();
     print(teamTitle.text);
    final Stream = FirebaseFirestore.instance.collection('news').where('team',isEqualTo: TeamName).snapshots();
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
                title: Text("Fpl Standings"),
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
                title: Text("Fpl Standings"),
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
                child: Text("Team $TeamName News"),
              ),
            ),
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Icon(
                  Icons.tv,
                  size: 50.0,
                  color: Colors.green,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Fpl news",
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
                    DataColumn(label: Text("headline")),
                    DataColumn(label: Text("news")),
                   
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
    title: Text("Post team news"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: teamname,
          decoration:
              InputDecoration(helperText: 'Headline', hintText: 'e.g Player A injured'),
        ),
        TextField(
          controller: points,
          maxLines: 2,
          decoration:
              InputDecoration(helperText: 'points', hintText: 'sergio aguero will be missing in action during the match'),
        ),
      ],
    ),
    actions: [
      FloatingActionButton(
        onPressed: () {
           FirebaseFirestore.instance
                    .collection("news")
                    .add({'title': teamname.text, 'message': points.text,'team':teamTitle.text});
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("news added successfully")));
                Navigator.of(context).pop();
          // FirebaseFirestore.instance
          //     .collection("teams")
          //     .where("Name", isEqualTo: teamname.text)
          //     .get()
          //     .then((QuerySnapshot query) {
          //   query.docs.forEach((doc) {
          //     if (doc.data()['Name'] == teamname.text) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(content: Text("team already exits")));
          //     } else {
               
          //     }
          //   });
          // });
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
      DataCell(Text(data['title']), onTap: () {
        Navigator.pushNamed(context, '/TeamStats', arguments: data['Name']);
      }),
      DataCell(
        Text(
          data['message'],
        ),
        placeholder: true,
        onTap: (){
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _editTeam(context, data['Name']));
        }
      ),
      // DataCell(IconButton(
      //   icon: Icon(Icons.delete,color: Colors.red,),
      //   onPressed: () {
      //     FirebaseFirestore.instance.collection('teams').where('Name',isEqualTo: data['Name']).get().then((QuerySnapshot snapshot){
      //       snapshot.docs.forEach((doc) { 
      //         FirebaseFirestore.instance.collection('teams').doc(doc.id).delete();
      //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('team ${doc.data()['Name']} was Deleted')));
      //       });
      //     });
      //   },
      // )),
    ],
  );
}

// edit Squad Details
Widget _editTeam(BuildContext context, String name) {
  return AlertDialog(
    title: Text("update Teams Points"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _updatepoints,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: '1+ points',
          ),
        ),
      ],
    ),
    actions: [
      FloatingActionButton(
        child: Icon(Icons.cloud_done),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('teams')
              .where('Name', isEqualTo: name)
              .get()
              .then((QuerySnapshot query) {
            query.docs.forEach((doc) {
              FirebaseFirestore.instance
                  .collection('teams')
                  .doc('${doc.id}')
                  .get()
                  .then((DocumentSnapshot doc) {
                String TN = doc.data()['Name'];
                String PNTs = doc.data()['points'];
                FirebaseFirestore.instance
                    .collection('teams')
                    .doc('${doc.id}')
                    .update({'points': _updatepoints.text});
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Points Updated")));
              });
            });
          });
        },
      )
    ],
  );
}
