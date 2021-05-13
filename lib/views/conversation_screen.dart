import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/uploadImages.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessagesStream;

  Widget chatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              return MessageTile(snapshot.data.docs[index].data()["message"],
                  snapshot.data.docs[index].data()["sendBy"] == Constants.myName);
              }): Container();
      },
    );
  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "sendBy" : Constants.myName,
        "message" : messageController.text,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      DataBaseMethods().addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    dataBaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                //color: Color(0xffffebee),
                decoration: BoxDecoration(
                border: Border(
                 top: BorderSide(width: 2.0, color: Color(0xffd6d6d6))
                )
                ),
                child: Row(
                  children: [ GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => UploadImages()
                      ));
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xffc62828),
                                  const Color(0xfffa4c50)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight
                            ),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/camera1.png",
                          height: 25, width: 25,)),
                  ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: whiteTextField(),
                        decoration: InputDecoration(
                            hintText: "Mensaje ...",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffc62828),
                                    const Color(0xfffa4c50)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Image.asset("assets/images/send.png",
                            height: 25, width: 25,)),
                    )
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSenByMe;
  MessageTile(this.message, this.isSenByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSenByMe ? 0 : 24, right: isSenByMe ? 24:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSenByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSenByMe ? [
              const Color(0xffc62828),
              const Color(0xfffa4c50)
            ]
                : [
              const Color(0xff000000),
              const Color(0xff000000)
            ],
          ),
          borderRadius: isSenByMe ?
              BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
              ):
          BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)
          )
        ),
        child: isSenByMe ? Text(message, style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),):
        Text(message, style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),)
      ),
    );
  }
}

