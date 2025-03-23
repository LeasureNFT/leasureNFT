import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/users/contollers/user_main_controller.dart';
import 'package:leasure_nft/app/users/screens/dashboard/task/controller/user_task_controller.dart';
import 'package:leasure_nft/app/users/screens/dashboard/task/view_task_screen.dart';

class UserTaskScreen extends GetView<UserTaskController> {
  final formkey = GlobalKey<FormState>();
  UserTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserTaskController>(
        init: UserTaskController(),
        builder: (controller) {
          return Scaffold(
              body: SafeArea(
                  child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Column(
              children: [
                Header(
                  title: "Task",
                  ontap: () {
                    final controller1 = Get.find<UserDashboardController>();
                    controller1.changePage(DashboardTab.home.index);
                    // controller1.pageController
                    //     .jumpToPage(DashboardTab.home.index);
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => Expanded(
                    child: controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.taskList.value.isEmpty
                            ? controller.errorMsg.value.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        size: 80,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                          textAlign: TextAlign.center,
                                          controller.errorMsg.value,
                                          style: AppTextStyles.adaptiveText(
                                                  context, 25)
                                              .copyWith(color: Colors.red)),
                                    ],
                                  )
                                : Center(
                                    child: Text(
                                      "No Task Found!",
                                      style: AppTextStyles.adaptiveText(
                                              context, 18)
                                          .copyWith(
                                              color: AppColors.blackColor300),
                                    ),
                                  )
                            : ListView.builder(
                                itemCount: controller.taskList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => ViewTaskScreen(
                                            task: controller.taskList[index],
                                          ));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      margin: EdgeInsets.only(bottom: 15.h),
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          boxShadow: [
                                            BoxShadow(
                                                color: AppColors.blackColor300,
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(0, 3))
                                          ]),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    controller.taskList[index]
                                                        ["title"],
                                                    style: AppTextStyles
                                                            .adaptiveText(
                                                                context, 18)
                                                        .copyWith(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                    controller.taskList[index]
                                                        ["description"],
                                                    style: AppTextStyles
                                                            .adaptiveText(
                                                                context, 16)
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 30,
                                            color: AppColors.accentColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                  ),
                )
              ],
            ),
          )));
        });
  }
}
