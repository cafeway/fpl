import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Follow extends StatelessWidget{
  const Follow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final TeamName = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Media links"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: _launchURL,
            title: Text("Facebook"),
            subtitle: Text("www.facebook.com/$TeamName"),
            leading: Icon(Icons.facebook,
            color: Colors.blue
            ),
          ),
          Divider(),
          ListTile(
            title: Text("Twitter"),
            subtitle: Text("www.twitter.com/$TeamName"),
            leading: Icon(Icons.send,
            color: Colors.blue
            ),
          ),
           Divider(),
          ListTile(
            title: Text("Instagram"),
            subtitle: Text("www.instagram.com/$TeamName"),
            leading: Icon(Icons.message,
            color: Colors.red
            ),
          ),
           Divider(),
          ListTile(
            title: Text("Whatsapp"),
            subtitle: Text("www.whatsapp.com/$TeamName"),
            leading: Icon(Icons.inbox,
            color: Colors.green
            ),
          ),
           Divider()
        ],),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
  
}

void _launchURL() async =>
    await canLaunch('www.google.com') ? await launch('www.google.com') : throw 'Could not launch';
