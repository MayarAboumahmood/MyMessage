// ignore_for_file: avoid_print
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/modules/message/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizza_app/modules/widgets/my_button.dart';
import 'package:pizza_app/modules/widgets/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../chats_screen/chat_screen.dart'; //this package use to apper the spen icon whel wating

class Registration extends StatefulWidget {
  static const String registration = 'Registration_bage';

  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _auth = FirebaseAuth.instance;

  bool _saving = false;
  String v = '';
  String confPassword = "";
  String password = "";
  String email = "";
  String userName = "";
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
                    'registar',
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
                    textType: TextInputType.name,
                    scurtext: false,
                    disableColor: Colors.blue,
                    enableColor: Colors.grey,
                    hintText: 'user name',
                    labletext: 'enter your name',
                    myonChange: (valua) {
                      userName = valua;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Mytextfield(
                    textType: TextInputType.emailAddress,
                    scurtext: false,
                    disableColor: Colors.blue,
                    enableColor: Colors.grey,
                    hintText: 'email adress',
                    labletext: 'enter your Email',
                    myonChange: (valua) {
                      email = valua;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Mytextfield(
                    textType: TextInputType.multiline,
                    scurtext: true,
                    disableColor: Colors.blue,
                    enableColor: Colors.grey,
                    hintText: 'password',
                    labletext: 'enter the password',
                    myonChange: (valua) {
                      password = valua;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Mytextfield(
                    textType: TextInputType.multiline,
                    scurtext: true,
                    disableColor: Colors.blue,
                    enableColor: Colors.grey,
                    hintText: 'conf password',
                    labletext: 'enter the confpassword',
                    myonChange: (value) {
                      confPassword = value;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  MyButton(
                      myheight: MediaQuery.of(context).size.height * 0.08,
                      mywidht: MediaQuery.of(context).size.width * 0.85,
                      mytext: 'register',
                      mycolor: Colors.black45,
                      myonpressed: () async {
                        setState(() {
                          _saving = true;
                        });
                        v = '';
                        if (userName != '' && password == confPassword) {
                          try {
                            CollectionReference users =
                                FirebaseFirestore.instance.collection('users');
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);
                            print(userCredential);
                            await users.doc(email).set({
                              'name': userName, // John Doe
                              'password': password, // Stokes and Sons
                              'email': email // 42
                            });
                            Navigator.of(context)
                                .pushReplacementNamed(MyMessage.messagebage);

                            setState(() {
                              _saving = false;
                            });
                          } on FirebaseAuthException catch (e) {
                            print('===============================');
                            if (e.code == 'weak-password') {
                              v = 'The password provided is too weak.';
                            } else if (e.code == 'email-already-in-use') {
                              v = 'The account already exists for that email.';
                            }
                          }
                        } else if (password != confPassword) {
                          v = "the password and the conferm password not equal";
                        } else if (userName == '' &&
                            password == '' &&
                            email == '') {
                          if (v == '') {
                            v = 'you have to fall the  inf';
                          }
                        } else if (userName == '') {
                          v = "the user name cant be null";
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
