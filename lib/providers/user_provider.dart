import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/course_model.dart';
import '../models/edit_avatar_response.dart';
import '../models/edit_name_response.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  CourseModel? _selectedCourse;
  UserModel? _user;

  CourseModel? get selectedCourse => _selectedCourse;
  UserModel? get user => _user;

  void setSelectedCourse(CourseModel course) {
    _selectedCourse = course;

    notifyListeners();
  }

  Future<EditAvatarResponse> setPicture(String path) async {
    File file = File(path);

    try {
      final response = await _storage.ref('avatars/${_user!.id}').putFile(file);

      String url = await response.ref.getDownloadURL();

      await _database.collection('users').doc(_user!.id).update({
        'picture': url,
      });

      _user!.picture = url;

      notifyListeners();

      return EditAvatarResponse(edited: true);
    } on FirebaseException catch (_) {
      return EditAvatarResponse(
        edited: true,
        error: 'Não foi possível alterar a foto de perfil.',
      );
    } catch (_) {
      return EditAvatarResponse(
        edited: true,
        error: 'Não foi possível alterar a foto de perfil.',
      );
    }
  }

  Future<void> removePicture() async {
    await _database.collection('users').doc(_user?.id).update({
      'picture': null,
    });

    _user!.picture = null;

    notifyListeners();
  }

  Future<EditNameResponse> editName(String name) async {
    try {
      await _database.collection('users').doc(_user?.id).update({
        'name': name,
      });

      _user!.name = name;

      notifyListeners();

      return EditNameResponse(edited: true);
    } on FirebaseException catch (e) {
      return EditNameResponse(edited: false, error: e.code);
    } catch (e) {
      return EditNameResponse(edited: false, error: e.toString());
    }
  }

  Future<void> loadUser({
    required String id,
    required List<CourseModel> courses,
  }) async {
    final doc = await _database.collection('users').doc(id).get();
    _user = await UserModel.fromMap(id: id, map: doc.data() ?? {});

    _selectedCourse = courses.first;

    notifyListeners();
  }
}
