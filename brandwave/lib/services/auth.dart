import "package:firebase_auth/firebase_auth.dart";
import "package:brandwave/models/CustomUser.dart";

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  CustomUser ? _userFromDB(User ? user) {
    return user != null ? CustomUser(
        uid: user.uid,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoURL: user.photoURL
    ) : null;
  }

  // creating stream to communicate with firebase
  Stream<CustomUser?> get user {
    return _auth
        .authStateChanges()
        .map((User ? user) => _userFromDB(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      final UserCredential result = await _auth.signInAnonymously();
      User ? user = result.user;
      return _userFromDB(user);
    }
    on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error");
      }
    }
  }

  // sign in with email and password
  Future signIn(String email, String password) async{
    try{
      final UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User ? user = result.user;
      return _userFromDB(user);
    }
    on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "User Account not Found";
        default:
          return null;
      }
    }
  }

  // sign up with email and password

  Future signUp (String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User ? user = result.user;
      return _userFromDB(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return null;
    } catch (e) {
      print(e);
    }
  }

  // sign out
  Future signOut () async {
    try {
        return await
        _auth.signOut();
    }
    catch (e) {
      print(e.toString());
    }
  }

}