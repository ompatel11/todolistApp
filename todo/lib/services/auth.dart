import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/user.dart';
import 'package:todo/services/database.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null? User(uid:user.uid) : null;
  }

  Stream <User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user)=> _userFromFirebaseUser(user));
  }
  //sign in anon
  // Future signInAnon() async {
  //   try {
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;

  //     await DatabaseService(uid: user.uid).addUserData('Titile', '4:00 p.m.');
  //     return _userFromFirebaseUser(user);
  //   } catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }
  
  //sign in with e-mail and password
  Future signInWithEmailAndPassword(String email,String password) async {
    try{  
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    } catch(e){
      print(e.toString());
      return null;
    }
  }
  // Register with Email and Password
  Future registerWithEmailAndPassword(String email, String password) async {

    try {

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;

      // create a new document for the user with the uid

      await DatabaseService(uid: user.uid).addUserData('Title of Task','Time of task');
      return _userFromFirebaseUser(user);

    } catch (error) {

      print(error.toString());

      return null;

    } 

  }
  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
    }
  }
}