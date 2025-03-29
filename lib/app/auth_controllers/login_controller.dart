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
      // Authenticate user
      await auth
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((v) async {
        if (v.user!.email != "admin@gmail.com") {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(v.user?.uid)
              .get();

          // Check if user exists in Firestore
          if (!userDoc.exists) {
            isLoading.value = false;
            MessageToast.showToast(msg: 'User not found in database');
            return;
          }

          // Check if user is banned
          bool isBanned = userDoc.data()?['isUserBanned'] ?? false;
          if (isBanned) {
            isLoading.value = false;
            MessageToast.showToast(
                msg: 'Your account has been banned. Please contact admin.');

            return;
          } else {
            Get.offAllNamed(AppRoutes.userDashboard);
          }
        } else {
          AppPrefernces.setAdmin("admin");
          Get.offAllNamed(AppRoutes.adminDashboard);
        }
        // Check if the user is an admin
      });

      // Get user data from Firestore

      isLoading.value = false;
      MessageToast.showToast(msg: 'Login Successfully');
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
