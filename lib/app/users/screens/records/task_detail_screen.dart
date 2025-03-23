import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';

class TaskDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot task;

  TaskDetailScreen({required this.task});
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                  title: "Task Details",
                  ontap: () {
                    Get.back();
                  }),
              SizedBox(height: 20.h),
              // Transaction ID
              Center(
                child: Text("${task['taskName']}",
                    style: AppTextStyles.adaptiveText(context, 25).copyWith(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Description",
                      style: AppTextStyles.adaptiveText(context, 18).copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                  VerticalDivider(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(task['taskDesc']!,
                          style: AppTextStyles.adaptiveText(context, 15)
                              .copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.normal)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Profit",
                      style: AppTextStyles.adaptiveText(context, 18).copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                  Text("Rs. ${task["profit"].toStringAsFixed(2)}",
                      style: AppTextStyles.adaptiveText(context, 15).copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              const SizedBox(height: 15),
              // Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 4.w),
                      Text("Rating",
                          style: AppTextStyles.adaptiveText(context, 18)
                              .copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold)),
                      SizedBox(width: 4.w),
                      Icon(Icons.star, color: Colors.amber, size: 18),
                    ],
                  ),
                  Text("${task['rating'].toStringAsFixed(1)} / 5",
                      style: AppTextStyles.adaptiveText(context, 15).copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              const SizedBox(height: 15),

              // Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Completed Date:",
                      style: AppTextStyles.adaptiveText(context, 18).copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                  Text(formatTimestamp(task['videoCompletedAt']),
                      style: AppTextStyles.adaptiveText(context, 15).copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              const SizedBox(height: 15),

              // Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Status",
                      style: AppTextStyles.adaptiveText(context, 18).copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                  Text("Completed",
                      style: AppTextStyles.adaptiveText(context, 15).copyWith(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal))
                ],
              ),

              const SizedBox(height: 20),

              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 20),
              CustomButton(
                  onPressed: () {
                    Get.back();
                  },
                  text: "Done")
            ],
          ),
        ),
      ),
    );
  }
}
