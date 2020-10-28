import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sc/widgets/messages.dart';
import 'package:sc/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fb = FirebaseMessaging();
    fb.requestNotificationPermissions();
    fb.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      return;
    }, onLaunch: (msg) {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Super chat'), actions: [
        DropdownButton(
          items: [
            DropdownMenuItem(
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
              ),
            ),
          ],
          underline: Container(),
          onChanged: (id) {
            FirebaseAuth.instance.signOut();
          },
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ),
      ]),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
