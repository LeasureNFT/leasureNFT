import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/constants.dart';
import 'package:leasure_nft/app/users/screens/dashboard/profile/controller/edit_profile_controller.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';

class UpdateProfileScreen extends GetView<EditProfileController> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
        init: EditProfileController(),
        builder: (controller) => Scaffold(
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Header(
                          title: "Edit Profile",
                          ontap: () {
                            Get.back();
                          }),
                      SizedBox(height: 20.h),
                      Center(
                        child: Stack(
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 60.r,
                                backgroundColor: Colors.lightBlue[100],
                                child: controller.base64Image.value.isNotEmpty
                                    ? ClipOval(
                                        // Ensures the image stays within the circle
                                        child: Image.memory(
                                          base64Decode(
                                              controller.base64Image.value),
                                          width: 160
                                              .r, // Should match the diameter (2 * radius)
                                          height: 160.r,
                                          fit: BoxFit
                                              .cover, // Cover ensures it fills the circle properly
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Colors.blue,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  controller.pickCahalanImage();
                                  // Add edit profile picture functionality here
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: kPrimaryColor, width: 2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomTextField(
                          title: "Name",
                          controller: controller.nameController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Name";
                            } else {
                              return null;
                            }
                          },
                          hintText: "Enter Name",
                          prefixIcon: Icons.person),
                      SizedBox(height: 10.h),
                      CustomTextField(
                          title: "Email",
                          readOnly: true,
                          controller: controller.emailController,
                          hintText: "Enter Email",
                          prefixIcon: Icons.email),
                      SizedBox(height: 10.h),
                      CustomTextField(
                          title: "Old Password",
                          controller: controller.oldPasswordController,
                          hintText: "Enter Old Password",
                          prefixIcon: Icons.lock),
                      SizedBox(height: 10.h),
                      CustomTextField(
                          title: "New Password",
                          controller: controller.passwordController,
                          hintText: "Enter New Password",
                          prefixIcon: Icons.lock),
                      SizedBox(height: 10.h),
                      CustomTextField(
                          title: "Confirm Password",
                          controller: controller.confirmPasswordController,
                          hintText: "Enter Confirm Password",
                          prefixIcon: Icons.lock),
                      SizedBox(height: 30.h),
                      Obx(
                        () => CustomButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                controller.updateProfile();
                              }
                            },
                            loading: controller.isLoading.value,
                            text: "Done"),
                      ),
                    ],
                  ),
                ),
              )),
            ));
  }
}
