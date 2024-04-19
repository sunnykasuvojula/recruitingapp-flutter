import 'package:firebase_auth/firebase_auth.dart';

class LoginService{
  FirebaseAuth _auth=FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential credentials=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credentials.user;
    }
    catch(e){
      print("Error occured");
    }
    return null;
  }


  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential credentials=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credentials.user;
    }
    catch(e){
      print("Error occured");
    }
    return null;
  }

}