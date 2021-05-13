import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/modal/user.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserF _userFromFireBaseUser(User user){
    return user != null ? UserF(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
      User fireBaseUser = result.user;
      return _userFromFireBaseUser(fireBaseUser);
    }catch(e){
      print(e);
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      User fireBaseUser = result.user;
      return _userFromFireBaseUser(fireBaseUser);
    }catch(e){
      print(e);
    }
  }

  Future resetPass(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){

    }
  }

}