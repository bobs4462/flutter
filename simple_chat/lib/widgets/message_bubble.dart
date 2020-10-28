import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final Key key;
  final String message;
  final String userName;
  final String userImage;
  MessageBubble(
    this.message,
    this.userName,
    this.userImage,
    this.isMe, {
    this.key,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 233,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 17),
              margin: EdgeInsets.symmetric(vertical: 19, horizontal: 13),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black : Colors.white,
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: isMe ? Colors.black : Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
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
        ),
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
            radius: 35,
          ),
          left: isMe ? null : 199,
          right: isMe ? 199 : null,
          top: 0,
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
