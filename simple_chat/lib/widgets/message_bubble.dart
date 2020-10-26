import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final Key key;
  final String message;
  MessageBubble(this.message, this.isMe, {this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 333,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 17),
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 13),
          child: Text(
            message,
            style: TextStyle(
              color: isMe ? Colors.black : Colors.white,
              fontSize: 24,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17),
              topRight: Radius.circular(17),
              bottomRight: Radius.circular(isMe ? 0 : 17),
              bottomLeft: Radius.circular(isMe ? 17 : 0),
            ),
            color: isMe ? Colors.indigo[200] : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
