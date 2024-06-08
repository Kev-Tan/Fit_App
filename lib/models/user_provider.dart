import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserProvider() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      _user = UserModel.fromMap(
          doc.data() as Map<String, dynamic>, currentUser.uid);
      notifyListeners();
    }
  }

  Future<void> updateUser(UserModel user) async {
    _user = user;
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
    notifyListeners();
  }

  Future<void> refreshUser() async {
    await _loadUser();
  }
}
