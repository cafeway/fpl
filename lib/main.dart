// ignore_for_file: prefer_const_constructors



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:fpl/screens/players.dart';


import './register.dart';
import './home.dart';
import './profile.dart';
import './teamDetails.dart';


// screens

import './screens/news.dart';
import './screens/events.dart';
import './screens/comments.dart';
import './screens/follow.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginDemo(),
        '/register': (context) => RegisterDemo(),
        '/home': (context) => MyHomePage(title: 'Home',),
        '/profile': (context) => Profile(),
        '/TeamStats': (context) => Details(),
        '/news': (context) => NewsPage(title: 'hjvjvhjv'),
        '/events': (context) => EventsPage(title: 'xx'),
        '/follow': (context) => Follow(),
        '/viewPlayers': (context) => PlayersState(),
        '/comments': (context) => comments(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  FirebaseAuth auth = FirebaseAuth.instance;
  // form key
  final _formKey = GlobalKey<FormState>();

  // text editing controllers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  //check for user

  // ignore: empty_constructor_bodie
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Welcome Back"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: Container(
                        width: 200,
                        height: 150,
                        /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                        child: const Icon(
                          Icons.lock,
                          color: Colors.blue,
                          size: 150.0,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0)
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
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
                FlatButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
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
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text)
                              .then((value) => 
                              Navigator.pushNamed(context, '/home')
                              );
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
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                MaterialButton(
                    child: Text(
                      'New User? Create Account',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
