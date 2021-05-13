import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/conversation_screen.dart';
import 'package:chat_app/views/search.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  Stream chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
             return ChatRoomsTile(
                 snapshot.data.docs[index].data()["chatRoomId"]
                     .toString()
                     .replaceAll("_", "")
                     .replaceAll(Constants.myName, ""),
                 snapshot.data.docs[index].data()["chatRoomId"],
             );
            }) : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }



  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    dataBaseMethods.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomsStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Image.asset("assets/images/logoApp.png", height: 25,),
       actions: [
         GestureDetector(
           onTap: (){
             authMethods.signOut();
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Authenticate()
             ));
           },
           child: Container(
             padding: EdgeInsets.symmetric(horizontal: 16),
               child: Icon(Icons.exit_to_app)),
         )
       ],
     ),
     body: chatRoomList(),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.search),
       backgroundColor: Color(0xfffa4c50),
       onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Search()
          ));
       },
     ),
   );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ConversationScreen(chatRoomId)
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white10,
        ),
        margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xfffa4c50),
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}",
              style: whiteTextField(),),
            ),
            SizedBox(width: 8,),
            Text(userName, style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w300),)
          ],
        ),
      ),
    );
  }
}
