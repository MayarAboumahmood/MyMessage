import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/modules/message/message.dart';
import 'package:pizza_app/modules/widgets/my_button.dart';
import 'package:pizza_app/modules/widgets/my_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../chats_screen/chat_screen.dart'; //this package help to apper the spen icon whel wating

class SignIn extends StatefulWidget {
  static const String signin = 'Sign_in_bage';
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _saving = false;

  late String v;
  late String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: _saving,
          child: SingleChildScrollView(
            child: Column(
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
                    'Sign in',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Mytextfield(
                    textType: TextInputType.emailAddress,
                    scurtext: false,
                    disableColor: Colors.grey,
                    enableColor: Colors.blue,
                    hintText: 'email adress',
                    labletext: 'enter your Email',
                    myonChange: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Mytextfield(
                    textType: TextInputType.multiline,
                    scurtext: true,
                    disableColor: Colors.grey,
                    enableColor: Colors.blue,
                    hintText: 'password',
                    labletext: 'enter the password',
                    myonChange: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  MyButton(
                      myheight: MediaQuery.of(context).size.height * 0.08,
                      mywidht: MediaQuery.of(context).size.width * 0.85,
                      mytext: 'sign in',
                      mycolor: Colors.blue,
                      myonpressed: () async {
                        setState(() {
                          _saving = true;
                        });
                        v = '';
                        if (password != '' || email != '') {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            Navigator.pushReplacementNamed(
                                context, Chats.chatsScreen);
                            setState(() {
                              _saving = false;
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              v = 'No user found for that email.';
                            } else if (e.code == 'swrong-password') {
                              v = 'Wrong password provided for that user.';
                            }
                          } catch (e) {
                            print(e);

                            if (v == '') {
                              v = "Erorr";
                            }
                          }
                        } else {
                          v = 'you have to fill the information';
                        }
                        setState(() {
                          _saving = false;
                        });
                        if (v != '') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO_REVERSED,
                            borderSide: const BorderSide(
                                color: Colors.blueGrey, width: 2),
                            buttonsBorderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                            headerAnimationLoop: false,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Erorr',
                            desc: v,
                            showCloseIcon: true,
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.165,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
