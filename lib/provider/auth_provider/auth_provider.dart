// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:today_news/helper/storage_helper/storage_helper.dart';
import 'package:today_news/routes/routes_name.dart';
import 'package:today_news/utils/toast_message.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  void createUser(String email, String password) {
    isLoading = true;
    notifyListeners();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          isLoading = false;
          notifyListeners();
          toastMessage("User Created Successfully");
        })
        .onError((error, stackTrace) {
          isLoading = false;
          notifyListeners();
          toastMessage(error.toString());
        });
  }

  void login(String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          UserCredential userCredential = value;
          log(userCredential.user!.uid);
          StorageHelper().setString(userCredential.user!.uid);
          isLoading = false;
          notifyListeners();
          log("Login Successfully");
          toastMessage("Login Successfully");
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.home,
            (_) => false,
          );
        })
        .onError((error, stackTrace) {
          isLoading = false;
          notifyListeners();
          log(error.toString());
          toastMessage(error.toString());
        });
  }
}
