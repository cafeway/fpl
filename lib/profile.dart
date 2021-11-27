// ignore_for_file: dead_code, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Profile extends StatelessWidget {
  TextEditingController username =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController gender =TextEditingController();
  TextEditingController nationality =TextEditingController();


  // const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection("fpl_users");

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("snapshot has error");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("The document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data();
          String Name = data['username'];
          String Email = data['email'];
          String Gender= data['gender'];
          String nation= data['nationality'];

          username.text = Name;
          email.text = Email;
          gender.text = Gender;
          nationality.text = nation;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Profile"),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                children: [
                        Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0,top: 30.0,bottom: 20.0),
                    child:Icon(
                      Icons.verified_user,
                      size: 40.0,
                    ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 20.0),
                    child: TextField(
                      controller: username,
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.supervised_user_circle_rounded),
                        hintText: "username",
                        helperText: "username",
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 20.0),
                    child: TextField(
                      controller: email,
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.mail),
                        hintText: "Email",
                        helperText: "address",
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 20.0),
                    child: TextField(
                      controller: gender,
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.toll_outlined),
                        hintText: "gender",
                        helperText: "gender",
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 20.0),
                    child: TextField(
                      controller: nationality,
                      readOnly: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.flag),
                        hintText: "username",
                        helperText: "nationality",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(child: Icon(Icons.edit),onPressed: (){

            },),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        }
        return Scaffold(
            appBar: AppBar(title: Text("user")),
            body: Center(
              child: const CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            ));
      },
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Profile"),
    //     centerTitle: true,
    //   ),
    // );
  }
}
