import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/users/screens/records/user_deposit_records.dart';
import 'package:leasure_nft/app/users/screens/records/user_task_records.dart';
import 'package:leasure_nft/app/users/screens/records/user_withdraw_records.dart';

class RecordScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          children: [
            Header(
                title: "Records",
                ontap: () {
                  Get.back();
                }),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Get.to(() => UserDepositRecords());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.3),
                          offset: Offset(0, 3),
                          blurRadius: 4,
                          spreadRadius: 1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Deposit Records',
                        style: AppTextStyles.adaptiveText(context, 16).copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.normal)),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryColor)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                Get.to(() => UserWithdrawRecords());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.3),
                          offset: Offset(0, 3),
                          blurRadius: 4,
                          spreadRadius: 1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Withdraw Records',
                        style: AppTextStyles.adaptiveText(context, 16).copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.normal)),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryColor)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                Get.to(() => UserTaskRecords());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.3),
                          offset: Offset(0, 3),
                          blurRadius: 4,
                          spreadRadius: 1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Task Records',
                        style: AppTextStyles.adaptiveText(context, 16).copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.normal)),
                    Icon(Icons.arrow_forward_ios_rounded,
                        color: AppColors.primaryColor)
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
