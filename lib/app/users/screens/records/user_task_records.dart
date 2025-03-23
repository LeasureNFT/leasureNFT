import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/users/screens/records/controller/user_task_record_controller.dart';
import 'package:leasure_nft/app/users/screens/records/task_detail_screen.dart';

class UserTaskRecords extends GetView<UserTaskRecordController> {
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('MMMM dd, yyyy hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserTaskRecordController>(
        init: UserTaskRecordController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
                child: Column(
                  children: [
                    Header(
                        title: "Task Records",
                        ontap: () {
                          Get.back();
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (controller.completedTasks.isEmpty) {
                          return Center(
                            child: Text(
                              "No completed tasks yet!",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp, color: Colors.black54),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: controller.completedTasks.length,
                          itemBuilder: (context, index) {
                            final task = controller.completedTasks[index];

                            return InkWell(
                              onTap: () {
                                Get.to(() => TaskDetailScreen(task: task));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                margin: EdgeInsets.only(bottom: 12.h),
                                elevation: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(task['taskName'],
                                                    style: AppTextStyles
                                                            .adaptiveText(
                                                                context, 18)
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                                SizedBox(height: 4.h),
                                                Text(task['taskDesc'],
                                                    style: AppTextStyles
                                                            .adaptiveText(
                                                                context, 15)
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color:
                                                          AppColors.blackColor,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Text("Completed",
                                              style: AppTextStyles.adaptiveText(
                                                      context, 15)
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.accentColor,
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Completed on: ${formatTimestamp(task['createdAt'])}",
                                              style: AppTextStyles.adaptiveText(
                                                      context, 15)
                                                  .copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: AppColors.blackColor,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
        });
  }
}
