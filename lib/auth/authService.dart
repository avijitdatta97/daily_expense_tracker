import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<bool> UserLogIn(String userMail, String userPassword) async{
    final credential = await _auth.signInWithEmailAndPassword(email: userMail, password: userPassword);

    return true;
  }

}