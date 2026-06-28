import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<User?> createAccountWithCode({
    required String email,
    required String password,
    required String schoolCode,
    required String name,
    required String surname,
    required String telNo,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'schoolCode': schoolCode,
          'createdAt': FieldValue.serverTimestamp(),
          'name': name,
          'surname': surname,
          'telNo': telNo,
        });

        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      final User? user = userCredential.user;

      if (user != null) {
        return user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
