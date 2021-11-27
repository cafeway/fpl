import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';

TextEditingController goals = TextEditingController();
TextEditingController cards = TextEditingController();

class PlayersState extends StatefulWidget{

  PlayersState({Key? key}) : super(key: key);@override
  State<PlayersState> createState() => PlayersPage();
}

class PlayersPage extends State<PlayersState>{
  @override
  Widget build(BuildContext context) {
    final Team = ModalRoute.of(context)!.settings.arguments;
    final Stream = FirebaseFirestore.instance.collection('players').orderBy('goals',descending:true).where('team',isEqualTo: Team).snapshots();
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
                title: Text("Team Players"),
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
                title: Text("Team Players"),
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
                child: const Text("FPL"),
              ),
            ),
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Icon(
                  Icons.sports_soccer,
                  size: 50.0,
                  color: Colors.blueAccent,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Team Players",
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
                    DataColumn(label: Text("name")),
                    DataColumn(label: Text("goals")),
                    DataColumn(label: Text("cards")),
                  ],
                  rows: _buildList(context, snapshot.data!.docs),
                ),
              ],
            ),

            // bottom Floating Action Button
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (BuildContext context) => _addteam(context));
            //   },
            //   tooltip: 'Share',
            //   child: const Icon(Icons.add),
            // ),
          );
        });
  }

}
// alert dialog to add a team to the league
// Widget _addteam(BuildContext context) {
//   // ignore: unnecessary_new
//   return new AlertDialog(
//     title: Text("Add New Team"),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         TextField(
//           controller: teamname,
//           decoration:
//               InputDecoration(helperText: 'team name', hintText: 'e.g team A'),
//         ),
//         TextField(
//           controller: points,
//           decoration:
//               InputDecoration(helperText: 'points', hintText: 'e.g 0pts'),
//         ),
//       ],
//     ),
//     actions: [
//       FloatingActionButton(
//         onPressed: () {
//           //  FirebaseFirestore.instance
//           //           .collection("teams")
//           //           .add({'Name': teamname.text, 'points': points.text});
//           //       ScaffoldMessenger.of(context).showSnackBar(
//           //           SnackBar(content: Text("team added successfully")));
//           //       Navigator.of(context).pop();
          
//         },
//         child: Icon(Icons.add),
//       )
//     ],
//   );
// }

List<DataRow> _buildList(
    BuildContext context, List<DocumentSnapshot> snapshot) {
  return snapshot.map((data) => _buildItems(context, data)).toList();
}

DataRow _buildItems(BuildContext context, DocumentSnapshot data) {
  return DataRow(
    cells: [
      DataCell(Text(data['name'])),
      DataCell(
        Text(
          data['goals'],
        ),
        placeholder: true,
        showEditIcon: true,
        onTap: (){
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _editGoals(context, data['name']));
        }
      ),
      DataCell(
        Text(
          data['cards'],
        ),
        placeholder: true,
        showEditIcon: true,
        onTap: (){
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _editCards(context, data['name']));
        }
      ),
    ],
  );
}

// edit Players Goals
Widget _editGoals(BuildContext context, String name) {
  return AlertDialog(
    title: Text("update Players goals"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: goals,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: 'Add Goals',
          ),
        ),
      ],
    ),
    actions: [
      FloatingActionButton(
        child: Icon(Icons.cloud_done),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('players')
              .where('name', isEqualTo: name)
              .get()
              .then((QuerySnapshot query) {
            query.docs.forEach((doc) {
              FirebaseFirestore.instance.collection('players').doc(doc.id).update({
                'goals': goals.text
              });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("goals updated successfully"))
            );
            Navigator.pop(context);
            });
          });
        },
      )
    ],
  );
}

// edit the number of cards a player has
Widget _editCards(BuildContext context, String name) {
  return AlertDialog(
    title: Text("update A Players Cards"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: cards,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: 'Update Cards',
          ),
        ),
      ],
    ),
    actions: [
      FloatingActionButton(
        child: Icon(Icons.cloud_done),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('players')
              .where('name', isEqualTo: name)
              .get()
              .then((QuerySnapshot query) {
            query.docs.forEach((doc) {
              FirebaseFirestore.instance.collection('players').doc(doc.id).update({
                'cards': cards.text
              });
                 ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("cards updated successfully"))
            );
            Navigator.pop(context);
            });
          });
        },
      )
    ],
  );
}