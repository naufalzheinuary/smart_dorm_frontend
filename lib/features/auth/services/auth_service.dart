import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ================= REGISTER =================

  Future<String?> register({

    required String name,
    required String email,
    required String password,

  }) async {

    try {

      final credential =
          await _auth
              .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      // SAVE USER TO FIRESTORE
      await _firestore
          .collection('users')
          .doc(uid)
          .set({

        'name': name,
        'email': email,

        // DEFAULT ROLE
        'role': 'user',

        'createdAt':
            Timestamp.now(),

      });

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;

    } catch (e) {

      return e.toString();

    }

  }

  // ================= LOGIN =================

  Future<String?> login({

    required String email,
    required String password,

  }) async {

    try {

      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;

    } catch (e) {

      return e.toString();

    }

  }

  // ================= GET ROLE =================

  Future<String?> getRole() async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

    return doc.data()?['role'];

  }

}