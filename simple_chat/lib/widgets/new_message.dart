import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _conroller = TextEditingController();
  var _message = '';
  Future<void> _sendMessage() async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    FirebaseFirestore.instance
        .collection('Chats/HD0UBwL33jJs6rxrpd4d/messages')
        .add({
      'text': _message,
      'timestamp': Timestamp.now(),
      'userId': userId,
      'userName': userData['userName'],
      'userImage': userData['image'],
    });
    _conroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                controller: _conroller,
                decoration: InputDecoration(labelText: 'Send a message'),
                onChanged: (v) {
                  setState(() {
                    _message = v;
                  });
                }),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _message.trim().isEmpty
                ? null
                : () {
                    FocusScope.of(context).unfocus();
                    _sendMessage();
                  },
          )
        ],
      ),
    );
  }
}
