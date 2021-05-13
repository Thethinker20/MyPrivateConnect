import 'dart:io';

import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({Key key}) : super(key: key);

  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {

  File _image;
final picker = ImagePicker();
  chooseImage(ImageSource source) async{
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Center(
        child: Column(
          children: [
            Container(
              child: _image == null ?
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(_image),
                      )
                    ),
                  )
                  :
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey
                    ),
                  )
            ),
            Container(
              //height: MediaQuery.of(context).size.height - 0.5,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){
                        chooseImage(ImageSource.camera);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xffc62828),
                                  const Color(0xfffa4c50)
                                ]
                            )
                        ),
                        child: Text("Camera", style: whiteTextField(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    GestureDetector(
                      onTap: (){
                        chooseImage(ImageSource.gallery);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xffc62828),
                                  const Color(0xfffa4c50)
                                ]
                            )
                        ),
                        child: Text("Upload", style: whiteTextField(),
                        ),
                      ),
                    ),
                    SizedBox(height:50,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


