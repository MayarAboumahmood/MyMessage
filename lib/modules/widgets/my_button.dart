import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String mytext;
  final VoidCallback
      myonpressed; //when 'myonpressed' frome data type Function it not work because the onPressed is aa viod function
  final Color mycolor;
  final double myheight;
  final double mywidht;
  const MyButton(
      {Key? key,
      required this.mytext,
      required this.myonpressed,
      required this.mycolor,
      required this.myheight,
      required this.mywidht})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 5,
        color: mycolor,
        borderRadius: BorderRadius.circular(15),
        child: MaterialButton(
          onPressed: myonpressed,
          minWidth: mywidht,
          height: myheight,
          child: Text(mytext,
              style: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}
