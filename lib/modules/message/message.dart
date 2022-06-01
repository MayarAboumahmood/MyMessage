import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chats_screen/chat_screen.dart';
import '../widgets/message_widget.dart';

class MyMessage extends StatefulWidget {
  static const String messagebage = 'MyMessage';
  String emailsend;
  String namesend;
  MyMessage({Key? key, required this.emailsend, required this.namesend})
      : super(key: key);

  @override
  _MyMessageState createState() => _MyMessageState();
}

class _MyMessageState extends State<MyMessage> {
  final messageTextController =
      TextEditingController(); //well clean the textField after sending the message
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User
      signinUser; //the "User" come frome the Firebase(the email aved here)
  String? messageText; //this well give us the message
  @override
  void initState() {
    super.initState();
    getCureentUser();
  }

  void getCureentUser() {
    try {
      final user = _auth
          .currentUser; // رح تاخذ قيمة صفر اذا ماكان في حدا مسجل دخول بس اذا كان مسجل دخول فرح نحصل من المتحول على ايميلو وكلملة السر لانو رح يجو من الاوبجكت للي بالنلاس الرجستريشن
      if (user != null) {
        signinUser = user;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Image.asset(
              'images/R.png',
              height: MediaQuery.of(context).size.height * .1,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * .01),
            const Text(
                "adlhaaa"
                // _fireStore
                //     .collection('users')
                //     .doc(_auth.currentUser!.email)
                //     .collection('myFriends')
                //     .doc(widget.namesend)
                //     .toString(),
                ,
                style: const TextStyle(fontSize: 20, color: Colors.white70))
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Chats.chatsScreen);
              },
              icon: const Icon(Icons.close)),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                List<MessageContinar> messagesWidgetS = [];
                if (!snapshot.hasData) {
                  return (Center(
                    heightFactor: MediaQuery.of(context).size.height * .02,
                    child: const CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  ));
                }
                final messages = snapshot.data!.docs.reversed;
                for (var m in messages) {
                  final messageText = m.get('text');
                  final messageSender = m.get('sender');
                  final currentUser = signinUser.email;

                  final messageWidget = MessageContinar(
                    sender: messageSender,
                    text: messageText,
                    isMe: currentUser == messageSender,
                  );
                  messagesWidgetS.add(messageWidget);
                  // print(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true, //لنخلي الشاشة تظهر الرسالة الجديدة تلقائيا
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .04,
                        vertical: MediaQuery.of(context).size.height * .02),
                    children: messagesWidgetS,
                  ),
                );
              },
              stream: _fireStore
                  .collection('users')
                  .doc(_auth.currentUser!.email)
                  .collection('myFriends')
                  .doc(widget.emailsend)
                  .collection('messages')
                  .orderBy('time')
                  .snapshots(),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: Colors.blue,
                  width: MediaQuery.of(context).size.width * .001,
                ),
              )),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Type somethink',
                        border: InputBorder.none),
                  )),
                  TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _fireStore
                            .collection('users')
                            .doc(_auth.currentUser!.email)
                            .collection('myFriends')
                            .doc(widget.emailsend)
                            .collection('messages')
                            .add({
                          'text': messageText,
                          'sender': signinUser.email,
                          'time': FieldValue
                              .serverTimestamp(), //give me the time when the message send
                        });
                      },
                      child: const Text(
                        'Send',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
