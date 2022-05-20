import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/course_model.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  CourseModel? _selectedCourse;
  UserModel? _user;

  CourseModel? get selectedCourse => _selectedCourse;
  UserModel? get user => _user;

  void setSelectedCourse(CourseModel course) {
    _selectedCourse = course;

    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();

    final account = await googleSignIn.signIn();
    if (account == null) {
      print('erro');
    } else {
      final authentication = await account.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      try {
        final userCredential = await _auth.signInWithCredential(credential);

        print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
        print(e);
      }
    }
  }

  Future<void> loadUser(List<CourseModel> courses) async {
    String id = "L8sUT5EftYM5cDSmYn4pdmrFE5z1";
    // TODO: Receber ID como parâmetro.

    final doc = await _database.collection('users').doc(id).get();
    _user = await UserModel.fromMap(id: id, map: doc.data() ?? {});

    _selectedCourse = courses.first;

    notifyListeners();
  }

  Future<void> signOut() async {
    _user = null;

    await _auth.signOut();
  }
}
