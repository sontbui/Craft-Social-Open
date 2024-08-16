// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart' as prefix;

import 'package:clone_gpt/authentications/opt_screen.dart';
import 'package:clone_gpt/utility/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isSuccessful = true;
  String? _uid;
  // keytool -exportcert -keystore debug.keystore -list -v
  String? _phoneNumber;
  String? _password;

  String? get uid => _uid;
  String get phoneNumber => _phoneNumber!;
  String? get password => _password;
  bool get isLoading => _isLoading;
  bool get isSuccessful => _isSuccessful;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  //method sign in
  void signInWithPhone(
      {required BuildContext context,
      required String phoneNumber,
      required RoundedLoadingButtonController buttonController}) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber, // Use the phoneNumber parameter here
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          _phoneNumber = phoneNumber; // Set _phoneNumber here
          notifyListeners();
          buttonController.success();
          Future.delayed(const Duration(seconds: 1)).whenComplete(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OTPScreen(
                  verificationId: '',
                ),
              ),
            );
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseException catch (e) {
      // Catch error exception
      buttonController.reset();
      showSnackbar(context: context, content: e.toString());
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      User? user =
          (await firebaseAuth.signInWithCredential(phoneAuthCredential)).user;
      if (user != null) {
        _uid = user.uid;
        notifyListeners();
        onSuccess();
      }
      _isLoading = false;
      _isSuccessful = true;
      notifyListeners();
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();
      showSnackbar(context: context, content: e.toString());
    }
  }
}
