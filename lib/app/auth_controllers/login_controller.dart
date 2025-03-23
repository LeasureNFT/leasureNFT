import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/widgets/toas_message.dart';
import 'package:leasure_nft/app/data/app_prefernces.dart';
import 'package:leasure_nft/app/routes/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final obscurePassword = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> loginUser() async {
    isLoading.value = true;
    try {
      await auth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((v) {
        if (emailController.text == "admin@gmail.com" &&
            passwordController.text == "admin123") {
          AppPrefernces.setAdmin("admin");
          Get.offAllNamed(AppRoutes.adminDashboard);
        } else {
          Get.offAllNamed(AppRoutes.userDashboard);
        }
        isLoading.value = false;
        MessageToast.showToast(msg: 'Login Successfully');
        // Get.offAll(DashboardScreen());
      }).onError((e, _) {
        isLoading.value = false;
        Get.log(e.toString());
        MessageToast.showToast(
            msg: 'Something went wrong, please try again $e');
      });
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'wrong-password') {
        MessageToast.showToast(msg: 'Invalid Password');
      } else if (e.code == 'user-not-found') {
        MessageToast.showToast(msg: 'User not found');
      } else {
        MessageToast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      isLoading.value = false;
      MessageToast.showToast(msg: 'Something went wrong');
    }
  }
}
