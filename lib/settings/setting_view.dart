import 'package:flutter/material.dart';
import 'package:pizza_app/modules/widgets/my_button.dart';

class Setting extends StatelessWidget {
  static const String settingbage = 'Setting';
  bool isEnglish = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            MyButton(
              mycolor: Colors.blue,
              myheight: MediaQuery.of(context).size.height * .02,
              mytext: "dark mode",
              mywidht: MediaQuery.of(context).size.width * .04,
              myonpressed: () {},
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            MyButton(
              mycolor: Colors.blue,
              myheight: MediaQuery.of(context).size.height * .02,
              mytext: isEnglish ? "Englash" : "Arabic",
              mywidht: MediaQuery.of(context).size.width * .04,
              myonpressed: () {},
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .55),
            const Text(
              'contact us here: 0930945782',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
