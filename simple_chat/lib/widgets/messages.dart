import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sc/widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Chats/HD0UBwL33jJs6rxrpd4d/messages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          final docs = chatSnapshot.data.documents;
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, i) => Container(
                padding: const EdgeInsets.all(8.0),
                child: MessageBubble(
                  docs[i]['text'],
                  docs[i]['userId'] == FirebaseAuth.instance.currentUser.uid,
                  key: ValueKey(docs[i].documentID),
                )),
            itemCount: docs.length,
          );
        });
  }
}
