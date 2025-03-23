// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/admin//controllers/dashboard_controller.dart';

import 'package:leasure_nft/app/admin//screens/add_user_screen.dart';
import 'package:leasure_nft/app/admin//screens/bounce_screen.dart';
import 'package:leasure_nft/app/admin//screens/task_history/task_history_screen.dart';
import 'package:leasure_nft/app/admin//screens/task/task_screen.dart';
import 'package:leasure_nft/app/admin//screens/transaction_screen.dart';
import 'package:leasure_nft/app/admin//screens/users_screen.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/assets/app_images.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/admin/screens/payment_methods.dart';

class AdminMainScreen extends GetView<DashboardController> {
  const AdminMainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
                  child: Column(
                    children: [
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                              radius: 27.r,
                              backgroundColor: Colors.grey.shade100,
                              child: Image.asset(AppImages.logo)),
                          title: Text('Admin',
                              style: AppTextStyles.adaptiveText(context, 20)
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor)),
                          subtitle: Text('Good Morning',
                              style: AppTextStyles.adaptiveText(context, 15)
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.blackColor)),
                          trailing: IconButton(
                              onPressed: () {
                                controller.logout();
                              },
                              icon: Icon(
                                Icons.logout,
                                color: AppColors.primaryColor,
                              ))),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 13.w, vertical: 15.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.accentColor
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: AppColors.whiteColor,
                                    size: 30.sp,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Total users',
                                      style: AppTextStyles.adaptiveText(
                                              context, 16)
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.whiteColor)),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Obx(
                                () => Text(
                                    controller.usersList.length.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        AppTextStyles.adaptiveText(context, 24)
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.whiteColor)),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 13.w, vertical: 15.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.accentColor
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.article,
                                    color: AppColors.whiteColor,
                                    size: 30.sp,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Total Revenue',
                                      style: AppTextStyles.adaptiveText(
                                              context, 16)
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.whiteColor)),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Obx(
                                () => Text(
                                    "Rs.${controller.totalRevenue.value.toStringAsFixed(2)}",
                                    textAlign: TextAlign.center,
                                    style:
                                        AppTextStyles.adaptiveText(context, 22)
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.whiteColor)),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      adminCard(
                        context: context,
                        text1: "Users",
                        ontap: () {
                          Get.to(() => UsersScreen());
                        },
                        iconPath: Icons.groups,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      adminCard(
                        context: context,
                        text1: "Add User",
                        ontap: () {
                          Get.to(() => AddUserScreen());
                        },
                        iconPath: Icons.group_add,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      adminCard(
                        context: context,
                        text1: "Send Bounce",
                        ontap: () {
                          Get.to(() => BounceScreen());
                        },
                        iconPath: Icons.attach_money_outlined,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      adminCard(
                        context: context,
                        text1: "Transactions",
                        ontap: () {
                          Get.to(() => AdminTransactionScreen());
                        },
                        iconPath: Icons.swap_horiz_outlined,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      adminCard(
                        context: context,
                        text1: "Payment Method",
                        ontap: () {
                          Get.to(() => PaymentMethodsScreen());
                        },
                        iconPath: Icons.payment,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      adminCard(
                        context: context,
                        text1: "Tasks",
                        ontap: () {
                          Get.to(() => TaskScreen());
                        },
                        iconPath: Icons.task_outlined,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      adminCard(
                        context: context,
                        text1: "Tasks History",
                        ontap: () {
                          Get.to(() => TaskHistoryScreen());
                        },
                        iconPath: Icons.history,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomButton(
                          onPressed: () {
                            controller.logout();
                          },
                          text: "Logout")
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget adminCard({context, text1, ontap, iconPath}) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                iconPath,
                color: AppColors.accentColor,
                size: 25.r,
              ),
              VerticalDivider(),
              Expanded(
                child: Text(
                  text1,
                  style: AppTextStyles.adaptiveText(context, 16).copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 25,
                color: AppColors.accentColor,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
