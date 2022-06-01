import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/modules/welcome_bage/welcome_bage.dart';
import 'package:pizza_app/settings/setting_view.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
      child: (Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'images/R.png',
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    const Text(
                      'message Me',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                  ],
                )),
            ListTile(
              title: drawerBotton(context, 'Settings'),
              onTap: () {
                Navigator.of(context).pushNamed(Setting.settingbage);
              },
            ),
            ListTile(
              title: drawerBotton(context, 'log out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed(WelcomeBage.welcome);
              },
            ),
          ],
        ),
      )),
    ));
  }
}

Container drawerBotton(BuildContext context, String d) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: const Color.fromARGB(26, 119, 169, 189),
    ),
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * .03),
    width: MediaQuery.of(context).size.width * .95,
    height: MediaQuery.of(context).size.width * .1,
    child: Text(
      d,
      // textAlign: TextAlign.left,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
