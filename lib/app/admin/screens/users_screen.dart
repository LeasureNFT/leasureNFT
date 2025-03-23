import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String image;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.image,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      fullName: data['username'] ?? 'No Name',
      email: data['email'] ?? 'No Email',
      image: data['image'] ?? '',
    );
  }
}

class UserController extends GetxController {
  RxList<UserModel> usersList = <UserModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // 🔹 Firestore سے Users حاصل کرنے کا Function
  void fetchUsers() {
    try {
      isLoading.value = true;
      FirebaseFirestore.instance
          .collection('users')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen(
        (snapshot) {
          usersList.value = snapshot.docs
              .map((doc) => UserModel.fromMap(doc.data(), doc.id))
              .toList();
          isLoading.value = false;
        },
        onError: (error) {
          isLoading.value = false;
          Get.snackbar('Error', 'Failed to fetch users: ${error.toString()}',
              snackPosition: SnackPosition.BOTTOM);
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class UsersScreen extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
          child: Column(
            children: [
              Header(
                  title: "Users",
                  ontap: () {
                    Get.back();
                  }),
              SizedBox(height: 20.h),
              Expanded(
                child: Obx(() {
                  if (controller.usersList.isEmpty) {
                    return Center(
                      child: Text('No users found.',
                          style: AppTextStyles.adaptiveText(context, 16)
                              .copyWith(color: AppColors.hintTextColor)),
                    );
                  } else if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 14.h),
                        itemCount: controller.usersList.length,
                        itemBuilder: (context, index) {
                          final user = controller.usersList[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    color: Colors.white,
                                    margin: EdgeInsets.symmetric(vertical: 5.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15.h,
                                        horizontal: 13.w,
                                      ),
                                      child: Row(
                                        children: [
                                          // 🔹 Image Handling: اگر Image null ہو تو Icon Show ہوگا ورنہ Base64 سے Decode ہوگا
                                          CircleAvatar(
                                            radius: 24.r,
                                            backgroundColor: AppColors
                                                .accentColor
                                                .withOpacity(0.5),
                                            child: user.image.isEmpty
                                                ? Icon(Icons.person,
                                                    color:
                                                        AppColors.primaryColor,
                                                    size: 28.sp)
                                                : ClipOval(
                                                    child: Image.memory(
                                                      base64Decode(user.image),
                                                      fit: BoxFit.cover,
                                                      width: 48.w,
                                                      height: 48.h,
                                                    ),
                                                  ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(user.fullName,
                                                    style: AppTextStyles
                                                            .adaptiveText(
                                                                context, 18)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                SizedBox(height: 4.h),
                                                Text(user.email,
                                                    style: AppTextStyles
                                                            .adaptiveText(
                                                                context, 16)
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
