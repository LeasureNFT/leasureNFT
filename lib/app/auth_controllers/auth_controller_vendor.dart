import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/auth_screens/user_login_screen.dart';
import 'package:leasure_nft/app/core/widgets/toas_message.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> resetmypassword() async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim())
          .then((v) {
        isLoading.value = false;
        MessageToast.showToast(msg: 'Password reset email sent');
        Get.to(() => UserLoginScreen());
      }).onError((error, stackTrace) {
        isLoading.value = false;
        Get.snackbar('Error', error.toString());
      });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
    }
  }
}
