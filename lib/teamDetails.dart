// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

TextEditingController playerName = TextEditingController();
class Details extends StatelessWidget {
  
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TeamName = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("$TeamName"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(padding: EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0,bottom: 10.0),
            child: CircleAvatar(
              radius: 60.0,
              child: Text("$TeamName"),
            ),
            ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0,bottom: 10.0),
                  child:ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, '/news',arguments: '$TeamName' );
                    },
                    leading: Icon(Icons.tv),
                    title: Text("News"),
                    tileColor: Colors.grey,
                    dense: false,
                    subtitle: Text("Read news about Your team")
                  ),
            ),
             // ignore: prefer_const_constructors
             Padding(
              padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0,bottom: 10.0),
                  // ignore: prefer_const_constructors
                  child:ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed('/events',arguments: TeamName);
                    },
                    leading: Icon(Icons.bolt),
                    title: Text("Events"),
                    tileColor: Colors.grey,
                    dense: false,
                    subtitle: Text("Find current  Matches")
                  ),
            ),
             Padding(
              padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0,bottom: 10.0),
                  child:ListTile(
                    onTap: (){
                      Navigator.pushNamed(context,'/comments');
                    },
                    leading: Icon(Icons.chat),
                    title: Text("Comments"),
                    tileColor: Colors.grey,
                    dense: false,
                    subtitle: Text("Leave Comments")
                  ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0,bottom: 10.0),
                  child:ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed('/follow',arguments: TeamName);
                    },
                    leading: Icon(Icons.remove_red_eye),
                    title: Text("Follow"),
                    tileColor: Colors.grey,
                    dense: false,
                    subtitle: Text("Follow Your Favourite team")
                  ),
            ),
             Padding(
              padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0,bottom: 10.0),
                  child:ListTile(
                    onTap: (){
                     showDialog(context: context, builder: (BuildContext context)=> _addPlayer(context, TeamName.toString()));
                    },
                    leading: Icon(Icons.sports_soccer),
                    title: Text("Add Players"),
                    tileColor: Colors.grey,
                    dense: false,
                    subtitle: Text("Add Players To team")
                  ),
            ),
             Padding(
              padding: EdgeInsets.only(top: 0.0,left: 20.0,right: 20.0,bottom: 10.0),
                  child:ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed('/viewPlayers',arguments: TeamName);
                    },
                    leading: Icon(Icons.remove_red_eye),
                    title: Text("View Players"),
                    tileColor: Colors.grey,
                    dense: false,
                    subtitle: Text("Follow Players Statistics")
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //view news
        },
        child: Icon(Icons.share),
        tooltip: 'share',
      ),
    );
  }
}

// widget to add players
Widget _addPlayer (BuildContext context,String teamName){
    return AlertDialog(
      title: Text("Add A New Player"),
      scrollable: true,
      content: Column(
        children: [
          TextField(
            controller: playerName,
            decoration: InputDecoration(
              hintText: "enter the players name",
            ),
          ),
        ],
      ) ,
      actions: [
        FloatingActionButton(
          onPressed: () {
           FirebaseFirestore.instance.collection('players').add({
                  'name': playerName.text,
                  'goals':'0',
                  'cards': '0',
                  'team': teamName,
                }).then((value){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The Player has been added successfully")));
                });
            },
          child: Icon(Icons.add)
        ),
      ],
    );
}