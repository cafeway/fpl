// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RegisterDemo extends StatefulWidget {
  const RegisterDemo({Key? key}) : super(key: key);

  @override
  _RegisterDemoState createState() => _RegisterDemoState();
}

class _RegisterDemoState extends State<RegisterDemo> {
  // text editing controllers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController nationality = TextEditingController();
  //check for user

  // ignore: empty_constructor_bodie
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create An Account"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: const Icon(
                      Icons.app_registration,
                      color: Colors.blue,
                      size: 80.0,
                    )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            //   const SizedBox(
            //   height: 40.0,
            // ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10, bottom: 10.0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 10.0),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(),
                    labelText: 'username',
                    hintText: 'choose a username e.g jane doe'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 10.0),
              child: TextField(
                controller: gender,
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(),
                    labelText: 'Gender',
                    hintText: 'Male or Female'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 10.0),
              child: TextField(
                controller: nationality,
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(),
                    labelText: 'nationality',
                    hintText: 'e.g kenyan'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 10.0),
              
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  if (email.text == '') {
                    scaffold.showSnackBar(SnackBar(
                        backgroundColor: Colors.blue,
                        content: const Text('Enter an Email')));
                  } else if (password.text == '') {
                    scaffold.showSnackBar(SnackBar(
                      content: const Text('Enter a Password'),
                      backgroundColor: Colors.blue,
                    ));
                  } else {
                    try {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email.text, password: password.text)
                          .then((value) =>
                          FirebaseFirestore.instance.collection('fpl_users').doc(value.user!.uid).set({
                            'username': username.text,
                            'email': email.text,
                            'gender': gender.text,
                            'nationality': nationality.text
                          }).then((value) =>
                           Navigator.pushNamed(context, '/login'))); 
                            
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "Firebase_auth/user-not-found") {
                        // scaffold.showSnackBar(SnackBar(
                        //   content:
                        //       const Text('No user Found with that email'),
                        //   backgroundColor: Colors.blue,
                        // ));
                        print("user-not-found");
                      } else {
                        scaffold.showSnackBar(SnackBar(
                          content: const Text('wrong Password'),
                          backgroundColor: Colors.blue,
                        ));
                      }
                    }
                  }
                  print(email.text);
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
