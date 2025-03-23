import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/admin//screens/task/controller/task_controller.dart';

class TaskScreen extends GetView<TaskController> {
  final formkey = GlobalKey<FormState>();
  TaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
        init: TaskController(),
        builder: (controller) {
          return Scaffold(
              floatingActionButton: InkWell(
                onTap: () {
                  Get.dialog(AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 18.h),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Add Payment Method",
                              style: AppTextStyles.adaptiveText(context, 20)
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomTextField(
                              prefixIcon: Icons.title,
                              title: "Title",
                              controller: controller.titleController,
                              hintText: "Enter Title",
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Title is required";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextField(
                              prefixIcon: Icons.description,
                              controller: controller.descriptionController,
                              title: "Description",
                              hintText: "Enter Description",
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Description is required";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextField(
                              prefixIcon: Icons.link,
                              controller: controller.urlController,
                              title: "Url",
                              hintText: "Enter Video Url",
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Url is required";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      controller.addTask();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 13.w, vertical: 10.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    backgroundColor: AppColors.primaryColor,
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    "Add",
                                    style:
                                        AppTextStyles.adaptiveText(context, 16)
                                            .copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                                VerticalDivider(),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 13.w, vertical: 10.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    backgroundColor: AppColors.blackColor300,
                                    elevation: 5,
                                  ),
                                  child: Text(
                                    "Cancel",
                                    style:
                                        AppTextStyles.adaptiveText(context, 16)
                                            .copyWith(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Add",
                    style: AppTextStyles.adaptiveText(context, 18)
                        .copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ),
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Column(
                  children: [
                    Header(
                      title: "Tasks",
                      ontap: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(
                      () => Expanded(
                        child: controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : controller.taskList.value.isEmpty
                                ? Center(
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
                                        onTap: () {},
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
                                                    color:
                                                        AppColors.blackColor300,
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
                                                        controller
                                                                .taskList[index]
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
                                                        controller
                                                                .taskList[index]
                                                            ["description"],
                                                        style: AppTextStyles
                                                                .adaptiveText(
                                                                    context, 15)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .blackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                        controller
                                                                .taskList[index]
                                                            ["url"],
                                                        style: AppTextStyles
                                                                .adaptiveText(
                                                                    context, 15)
                                                            .copyWith(
                                                                color: AppColors
                                                                    .blackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    controller.deleteTask(
                                                        id: controller
                                                                .taskList[index]
                                                            ["id"]);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_forever,
                                                    size: 30,
                                                    color: AppColors.errorColor,
                                                  ))
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
