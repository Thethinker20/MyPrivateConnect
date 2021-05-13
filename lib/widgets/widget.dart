import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
      title: Image.asset("assets/images/logoApp2.png", height: 20,),
  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color: Colors.white
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
  );
}

TextStyle simpleTextField(){
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
}

TextStyle whiteTextField(){
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}