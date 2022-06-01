// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_app/modules/widgets/anthorUser.dart';
import 'package:pizza_app/modules/widgets/mydrawer.dart';

class Chats extends StatelessWidget {
  static const String chatsScreen = 'Chats Bage';

  static List<String> nn = [];
  static List<String> ee = [];
  final _auth = FirebaseAuth.instance;
  late User
      signinUser; //the "User" come frome the Firebase(the email aved here)
  bool t = true;

  getUser() async {
    //CollectionRefrence نوع لبكوبكشن بالفاير ستور
    CollectionReference usersref =
        FirebaseFirestore.instance.collection("users");
    // .doc(_auth.currentUser!.email)
    // .collection('allchats');
    QuerySnapshot querySnapshot = await usersref.get();
    List<QueryDocumentSnapshot> listdocs = querySnapshot.docs;

    for (var element in listdocs) {
      if (element['email'] != _auth.currentUser!.email) {
        nn.add(element['name']);
        ee.add(element['email']);
      }
    }
    return nn;
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
          title: const Text(
            'Message Me',
            style: TextStyle(fontSize: 20, color: Colors.white70),
          ),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder(
            future: getUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print(snapshot.data);
              if (t == true) {
                nn.clear();
                ee.clear();
              }
              t = false;
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: nn.length,
                    itemBuilder: (contixt, i) {
                      return Anathor(
                        userName: nn[i],
                        userEmail: ee[i],
                      );
                    });
              } else if (snapshot.hasError) {
                return (Text("Something went wrong"));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));

    // builder(
    //     itemCount: nn.length,
    //     itemBuilder: (context, i) {
    //       return Anathor(userName: nn[i]);
    //     }));
  }
}
