import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';

class AddUserController extends GetxController {
  final isloading = false.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void addUser() async {
    try {
      isloading.value = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Add user data to Firestore
      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': emailController.text.trim(),
          'userId': userCredential.user!.uid,
          'username': "",
          "password": passwordController.text.trim(),
          "depositAmount": "0",
          "withdrawAmount": "0",
          "reward": "0",
          "cashVault": "0",
          "createdAt": FieldValue.serverTimestamp(),
          'image': ''
        });

        isloading.value = false;
        Fluttertoast.showToast(msg: "User added successfully");
        Get.back();
      }
    } catch (e) {
      isloading.value = false;
      Fluttertoast.showToast(msg: "Error adding user: $e");
    }
  }
}

class AddUserScreen extends GetView<AddUserController> {
  final formkey = GlobalKey<FormState>();
  AddUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUserController>(
        init: AddUserController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Header(
                          title: "Add User",
                          ontap: () {
                            Get.back();
                          }),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        hintText: "Enter Email",
                        title: "Email",
                        prefixIcon: Icons.email,
                        controller: controller.emailController,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please enter email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      CustomTextField(
                        title: "Password",
                        hintText: "Enter Password",
                        prefixIcon: Icons.lock,
                        controller: controller.passwordController,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please enter password";
                          }
                          if (v.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Obx(
                        () => CustomButton(
                            loading: controller.isloading.value,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                controller.addUser();
                              }
                            },
                            text: "Add"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildTextField(
      String hint, IconData icon, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black12, width: 2),
        ),
      ),
      style: TextStyle(fontSize: 16),
    );
  }
}
