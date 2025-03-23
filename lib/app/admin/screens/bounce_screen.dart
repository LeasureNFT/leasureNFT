import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';

class BounceController extends GetxController {
  final isloading = false.obs;
  final TextEditingController bounceController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final RxList<QueryDocumentSnapshot> usersList = <QueryDocumentSnapshot>[].obs;
  final RxList<QueryDocumentSnapshot> filteredUsers =
      <QueryDocumentSnapshot>[].obs;
  final RxString selectedUserId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // Fetch all users from Firebase
  Future<void> fetchUsers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    usersList.value = snapshot.docs;
    filteredUsers.value = snapshot.docs;
  }

  // Search users dynamically
  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = usersList;
    } else {
      filteredUsers.value = usersList.where((user) {
        String name = user['username'].toString().toLowerCase();
        String email = user['email'].toString().toLowerCase();
        return name.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase());
      }).toList();
    }
  }

  // Send bounce to either all users or a specific user
  Future<void> sendBounce() async {
    if (bounceController.text.isEmpty) {
      Get.snackbar("Error", "Please enter a bounce amount",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    double bounceAmount = double.tryParse(bounceController.text) ?? 0;
    if (bounceAmount <= 0) {
      Get.snackbar("Error", "Enter a valid bounce amount",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isloading.value = true;

    if (selectedUserId.value.isEmpty) {
      // Send bounce to all users
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      for (var user in snapshot.docs) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.id)
            .update({
          "reward": FieldValue.increment(bounceAmount),
          "cashVault": FieldValue.increment(bounceAmount),
        });
      }
      Get.snackbar("Success", "Bounce sent to all users!",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      // Send bounce to a specific user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(selectedUserId.value)
          .update({
        "reward": FieldValue.increment(bounceAmount),
        "cashVault": FieldValue.increment(bounceAmount),
      });
      Get.snackbar("Success", "Bounce sent to the selected user!",
          snackPosition: SnackPosition.BOTTOM);
    }

    isloading.value = false;
    bounceController.clear();
  }
}

class BounceScreen extends GetView<BounceController> {
  const BounceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BounceController>(
        init: BounceController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Header(
                        title: "Send Bonus",
                        ontap: () {
                          Get.back();
                        }),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      hintText: "Enter Bonus Amount",
                      prefixIcon: Icons.attach_money_outlined,
                      controller: controller.bounceController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Bonus Amount";
                        }
                        return null;
                      },
                    ),

                    // Search Bar
                    // TextFormField(
                    //   controller: controller.searchController,
                    //   onChanged: controller.searchUsers,
                    //   decoration: InputDecoration(
                    //     enabled: true,
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide: BorderSide(color: Colors.blue),
                    //     ),
                    //     prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                    //     hintText: "Search user by name or email",
                    //     hintStyle: TextStyle(color: Colors.grey),
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     contentPadding:
                    //         EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //       borderSide: BorderSide.none,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    // Obx(
                    //   () => DropdownSearch<String>(
                    //     // 👈 `null` return karna safe hai
                    //     enabled: controller.isloading.value ? false : true,
                    //     popupProps: PopupProps.menu(
                    //       showSearchBox: true, // 👈 Enable search box
                    //       searchFieldProps: TextFieldProps(
                    //         decoration: InputDecoration(
                    //           filled: true,
                    //           fillColor: AppColors.accentColor.withOpacity(0.1),
                    //           enabled: true,
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //             borderSide:
                    //                 BorderSide(color: AppColors.primaryColor),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //             borderSide:
                    //                 BorderSide(color: AppColors.primaryColor),
                    //           ),
                    //           labelText: "Search User",
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     items: controller.filteredUsers
                    //         .map((user) => user['username'] as String)
                    //         .toList(),
                    //     dropdownDecoratorProps: DropDownDecoratorProps(
                    //       dropdownSearchDecoration: InputDecoration(
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //           borderSide:
                    //               BorderSide(color: AppColors.primaryColor),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //           borderSide:
                    //               BorderSide(color: AppColors.primaryColor),
                    //         ),
                    //         hintText: "Select a user (or leave empty for all)",
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //           borderSide:
                    //               BorderSide(color: AppColors.primaryColor),
                    //         ),
                    //         filled: true,
                    //         fillColor: AppColors.accentColor.withOpacity(0.1),
                    //       ),
                    //     ),
                    //     onChanged: (value) {
                    //       final selectedUser =
                    //           controller.filteredUsers.firstWhere(
                    //         (user) => user['username'] == value,
                    //         // 👈 `null` return karna safe hai
                    //       );

                    //       // Agar user mila toh uska ID set karo, warna empty string rakho
                    //       controller.selectedUserId.value =
                    //           selectedUser != null ? selectedUser.id : '';
                    //     },
                    //     selectedItem: controller.filteredUsers
                    //             .where((user) =>
                    //                 user.id == controller.selectedUserId.value)
                    //             .isNotEmpty
                    //         ? controller.filteredUsers.firstWhere(
                    //             (user) =>
                    //                 user.id == controller.selectedUserId.value,
                    //           )['username'] // 👈 Directly access username
                    //         : null, // 👈 If user is not found, keep it null
                    //   ),
                    // ),
                    Obx(
                      () => DropdownSearch<String>(
                        enabled: !controller.isloading.value,
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.accentColor.withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              labelText: "Search User",
                            ),
                          ),
                        ),
                        items: controller.filteredUsers
                            .map((user) => user['username'] as String)
                            .toList(),

                        // 👈 New parameter
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(
                              color: Colors
                                  .black), // 👈 Replace this with your required style
                          textAlign: TextAlign.left,
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                            ),
                            hintText: "Select a user (or leave empty for all)",
                            filled: true,
                            fillColor: AppColors.accentColor.withOpacity(0.1),
                          ),
                        ),
                        onChanged: (value) {
                          final selectedUser =
                              controller.filteredUsers.firstWhere(
                            (user) => user['username'] == value,
                          );

                          controller.selectedUserId.value = selectedUser != null
                              ? selectedUser['userId']
                              : '';
                        },
                        selectedItem: controller.filteredUsers
                                .where((user) =>
                                    user['userId'] ==
                                    controller.selectedUserId.value)
                                .isNotEmpty
                            ? controller.filteredUsers.firstWhere(
                                (user) =>
                                    user['userId'] ==
                                    controller.selectedUserId.value,
                              )['username']
                            : null,
                      ),
                    ),

                    SizedBox(height: 30),

                    // Send Bounce Button
                    Obx(() => CustomButton(
                        onPressed: () {
                          controller.sendBounce();
                        },
                        loading: controller.isloading.value,
                        text: "Send")),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
