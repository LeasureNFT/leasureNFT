import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String image;
  bool isBanned; // ✅ Add this field

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.image,
    this.isBanned = false, // ✅ Default false if not specified
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      fullName: data['username'] ?? 'No Name',
      email: data['email'] ?? 'No Email',
      image: data['image'] ?? '',
      isBanned: data['isUserBanned'] ?? false, // ✅ Fetch from Firestore
    );
  }

  // 🔹 Convert UserModel to Map (for Firestore updates)
  Map<String, dynamic> toMap() {
    return {
      'username': fullName,
      'email': email,
      'image': image,
      'isUserBanned': isBanned, // ✅ Include isBanned in Firestore data
    };
  }
}

class UserController extends GetxController {
  RxList<UserModel> usersList = <UserModel>[].obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs;
  final isLoading = false.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // 🔹 Fetch Users from Firestore
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
          filteredUsers.assignAll(usersList);
          isLoading.value = false;
        },
        onError: (error) {
          isLoading.value = false;

          // 🚨 Handle Firestore errors
          Fluttertoast.showToast(
            msg: 'Failed to fetch users: ${error.toString()}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        },
      );
    } catch (e) {
      isLoading.value = false;
      // 🚨 Handle general errors
      Fluttertoast.showToast(
        msg: 'An error occurred: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      Get.log("Error from get users admin $e");
    }
  }

  // 🔎 Search Users by Name
  void searchUser(String query) {
    if (query.isEmpty) {
      filteredUsers.assignAll(usersList);
    } else {
      filteredUsers.assignAll(usersList.where(
        (user) => user.fullName.toLowerCase().contains(query.toLowerCase()),
      ));
    }
  }

  // 🚫 Toggle Ban/Unban User
  Future<void> toggleBanUser(UserModel user) async {
    bool newStatus = !(user.isBanned);
    await FirebaseFirestore.instance.collection('users').doc(user.id).update({
      'isUserBanned': newStatus,
    });

    // 🔄 Update local state
    user.isBanned = newStatus;
    usersList.refresh();
    filteredUsers.refresh();

    Fluttertoast.showToast(
      msg: newStatus
          ? "${user.fullName} has been banned"
          : "${user.fullName} is now unbanned",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
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
                ontap: () => Get.back(),
              ),
              SizedBox(height: 10.h),

              // 🔍 Search Bar
              TextField(
                controller: controller.searchController,
                onChanged: controller.searchUser,
                decoration: InputDecoration(
                  hintText: "Search by name...",
                  prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.filteredUsers.isEmpty) {
                    return Center(
                      child: Text(
                        'No users found.',
                        style: AppTextStyles.adaptiveText(context, 16)
                            .copyWith(color: AppColors.hintTextColor),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.only(bottom: 14.h),
                    itemCount: controller.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = controller.filteredUsers[index];

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
                                      // 🔹 User Profile Image
                                      CircleAvatar(
                                        radius: 24.r,
                                        backgroundColor: AppColors.accentColor
                                            .withOpacity(0.5),
                                        child: user.image.isEmpty
                                            ? Icon(Icons.person,
                                                color: AppColors.primaryColor,
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

                                      // 🔹 User Info
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
                                                            FontWeight.bold)),
                                            SizedBox(height: 4.h),
                                            Text(user.email,
                                                style:
                                                    AppTextStyles.adaptiveText(
                                                            context, 16)
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor)),
                                          ],
                                        ),
                                      ),

                                      // 🚫 Ban/Unban Button
                                      IconButton(
                                        icon: Icon(
                                          user.isBanned == true
                                              ? Icons.block
                                              : Icons.check_circle,
                                          color: user.isBanned == true
                                              ? Colors.red
                                              : Colors.green,
                                          size: 28.sp,
                                        ),
                                        onPressed: () =>
                                            controller.toggleBanUser(user),
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
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
