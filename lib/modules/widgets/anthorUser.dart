import 'package:flutter/material.dart';
import 'package:pizza_app/modules/chats_screen/chat_screen.dart';
import 'package:pizza_app/modules/message/message.dart';
import '../welcome_bage/welcome_bage.dart';

class Anathor extends StatelessWidget {
  const Anathor({Key? key, required this.userName, required this.userEmail})
      : super(key: key);
  final String userName;
  final String userEmail;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyMessage(
                      emailsend: userEmail,
                      namesend: userName,
                    )));
        // Navigator.of(context).pushReplacement(MyMessage(usersend: 'k'));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .01,
            vertical: MediaQuery.of(context).size.height * .005),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
              color: Color.fromARGB(26, 119, 169, 189),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(55))),
          width: MediaQuery.of(context).size.width * .95,
          height: MediaQuery.of(context).size.height * .11,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: Image.asset(
                  'images/R.png',
                  height: MediaQuery.of(context).size.height * .1,
                ),
              ),
              Text(
                userName,
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
