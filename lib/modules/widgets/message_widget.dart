import 'package:flutter/material.dart';

class MessageContinar extends StatelessWidget {
  const MessageContinar({Key? key, this.sender, this.text, required this.isMe})
      : super(key: key);

  final String? sender;
  final String? text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text("$sender",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black45,
              )),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15)),
            color: isMe ? Colors.blue : Colors.grey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .04,
                  vertical: MediaQuery.of(context).size.height * .01),
              child: Text(
                '$text',
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
