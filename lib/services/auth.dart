import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:netninja_flutter_firebase/models/user.dart';
import 'package:netninja_flutter_firebase/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebaseUser
  UserData? _userFromFirebaseUser(User? user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

// auth change user stream
  Stream<UserData?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    await Firebase.initializeApp();
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      // print("Result: ${result}");
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error);
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error);
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
