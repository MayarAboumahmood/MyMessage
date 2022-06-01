import 'package:flutter/material.dart';
import 'package:pizza_app/modules/registration/registration.dart';
import 'package:pizza_app/modules/sign_in/sign_in.dart';
import 'package:pizza_app/modules/widgets/my_button.dart';

class WelcomeBage extends StatefulWidget {
  static const String welcome = 'Welcome_bage';

  const WelcomeBage({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<WelcomeBage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/R.png'),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.002,
            ),
            const Text(
              'My Message',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            MyButton(
              myheight: MediaQuery.of(context).size.height * 0.08,
              mywidht: MediaQuery.of(context).size.width * 0.85,
              mytext: 'sign in',
              mycolor: Colors.blueAccent,
              myonpressed: () {
                Navigator.pushReplacementNamed(context, SignIn.signin);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            MyButton(
              myheight: MediaQuery.of(context).size.height * 0.08,
              mywidht: MediaQuery.of(context).size.width * 0.85,
              mytext: 'register',
              mycolor: Colors.black45,
              myonpressed: () {
                Navigator.pushReplacementNamed(
                    context, Registration.registration);
              },
            )
          ],
        ),
      ),
    );
  }
}
