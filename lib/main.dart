import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/modules/chats_screen/chat_screen.dart';
import 'package:pizza_app/modules/registration/registration.dart';
import 'package:pizza_app/modules/sign_in/sign_in.dart';
import 'package:pizza_app/modules/welcome_bage/welcome_bage.dart';
import 'package:firebase_core/firebase_core.dart'; //import it before using FireBase
import 'package:pizza_app/settings/setting_view.dart';
import 'modules/message/message.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //first think before using fireBase stuff
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Message',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: WelcomeBage.welcome,
      initialRoute:
          _auth.currentUser != null ? Chats.chatsScreen : WelcomeBage.welcome,
      routes: {
        Chats.chatsScreen: (context) => Chats(),
        WelcomeBage.welcome: (context) => const WelcomeBage(),
        SignIn.signin: (context) => const SignIn(),
        Registration.registration: (context) => const Registration(),
        Setting.settingbage: (context) => Setting(),
      },
    );
  }
}
