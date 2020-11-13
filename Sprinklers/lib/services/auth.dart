import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class AuthService {
  

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserID _userFromFirebaseUser(User user) {
    return user != null ? UserID(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserID> get user {
    return _auth.authStateChanges()
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('Mason','Horder');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}