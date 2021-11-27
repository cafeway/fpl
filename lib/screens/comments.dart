import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';


TextEditingController comment = TextEditingController();
String username='';

 class comments extends StatefulWidget {
  comments({Key? key}) : super(key: key);

  @override
  commentsState createState() => commentsState();
}

class commentsState extends State<comments>{
  @override
  Widget build(BuildContext context) {
    final TeamName = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome To The ChatRoom"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          showDialog(context: context, builder: (BuildContext context) => _comment(context, TeamName.toString()) );
        },
        child: Icon(Icons.comment)
        ,),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('comments').where('team',isEqualTo: TeamName).snapshots(),
          builder: (context,snapshot){
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.comment_bank),
                    subtitle: Text(doc.data()['comment']),
                    // trailing: Text(doc.data()['time'].toString()),
                    title: Text(doc.data()['user'])),
                    
                );
              }).toList(),
            );
          }),
    );
  }
}

Widget _comment(BuildContext context,String team){
  return AlertDialog(
    title: Text('Add Comment'),
    scrollable: true,
    content: Column(
      children: [
        TextField(
          controller: comment,
          decoration: InputDecoration(
            hintText: 'Add A Comment'
          ),
        ),
      ],
    ),
    actions: [
      FloatingActionButton(
        onPressed: (){
          FirebaseFirestore.instance.collection('fpl_users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot doc){
              username =  doc.data()['username']; 
              FirebaseFirestore.instance.collection('comments').add({
                'user':username,
                'comment': comment.text,
                'time': DateTime.now(),
                'likes': 0,
                'team': team,
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("comment added")));
              Navigator.of(context).pop();
          });
        },
        child: Icon(Icons.send),
      ),
    ],
  );
}