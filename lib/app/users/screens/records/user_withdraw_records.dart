import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/admin/screens/transaction_detail_screen.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/users/screens/records/controller/user_withdraw_record_controller.dart';

class UserWithdrawRecords extends GetView<UserWithdrawRecordController> {
  const UserWithdrawRecords({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserWithdrawRecordController>(
        init: UserWithdrawRecordController(),
        builder: (controller) => Scaffold(
              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    children: [
                      Header(
                          title: "Withdraw Records",
                          ontap: () {
                            Get.back();
                          }),
                      SizedBox(
                        height: 15.h,
                      ),
                      Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: AppColors.blackColor200,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              swapButton(
                                buttonColor: controller.currentTab.value == 0
                                    ? AppColors.accentColor
                                    : AppColors.transparentColor,
                                context: context,
                                ontap: () {
                                  controller.changeTab(0);
                                },
                                text: "Pending",
                                textColor: controller.currentTab.value == 0
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                              ),
                              swapButton(
                                buttonColor: controller.currentTab.value == 1
                                    ? AppColors.accentColor
                                    : AppColors.transparentColor,
                                context: context,
                                ontap: () {
                                  controller.changeTab(1);
                                },
                                text: "Completed",
                                textColor: controller.currentTab.value == 1
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                              ),
                              swapButton(
                                buttonColor: controller.currentTab.value == 2
                                    ? AppColors.accentColor
                                    : AppColors.transparentColor,
                                context: context,
                                ontap: () {
                                  controller.changeTab(2);
                                },
                                text: "Cancelled",
                                textColor: controller.currentTab.value == 2
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return Center(
                                child:
                                    CircularProgressIndicator()); // 🔄 Loading state
                          }

                          if (controller.errorMessage.isNotEmpty) {
                            return Center(
                                child: Text(controller.errorMessage.value,
                                    style: TextStyle(
                                        color: Colors.red))); // ❌ Error state
                          }

                          return controller.currentTab.value == 0
                              ? _buildPaymentList(controller.pendingPayments,
                                  "No Pending Withdraw", context)
                              : controller.currentTab.value == 1
                                  ? _buildPaymentList(
                                      controller.completedPayments,
                                      "No Completed Withdraw",
                                      context)
                                  : _buildPaymentList(
                                      controller.cancelledPayments,
                                      "No Cancelled Withdraw",
                                      context);
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _buildPaymentList(List payments, String emptyMessage, context) {
    return payments.isEmpty
        ? Center(
            child: Text(emptyMessage,
                style: AppTextStyles.adaptiveText(context, 15)
                    .copyWith(color: AppColors.blackColor300)))
        : ListView.builder(
            itemCount: payments.length,
            itemBuilder: (context, index) {
              var payment = payments[index];
              return InkWell(
                onTap: () {
                  Get.to(() => TransactionDetailScreen(
                        transaction: payment,
                        isFormAmin: false,
                      ));
                },
                child: Card(
                  elevation: 7,
                  child: ListTile(
                    title: Text(
                        "Transaction ID: ${payment['transactionId'] ?? 'Loading..'}",
                        style: AppTextStyles.adaptiveText(context, 18).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        )),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(payment['accountName'] ?? 'No Name',
                            style: AppTextStyles.adaptiveText(context, 15)
                                .copyWith(
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryColor,
                            )),
                        Text(
                          "Amount: ${payment['amount'] ?? '0'}",
                          style:
                              AppTextStyles.adaptiveText(context, 15).copyWith(
                            fontWeight: FontWeight.normal,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(payment['status'],
                        style: AppTextStyles.adaptiveText(context, 16).copyWith(
                            fontWeight: FontWeight.normal,
                            color: payment['status'] == "pending"
                                ? AppColors.primaryColor
                                : payment['status'] == "completed"
                                    ? AppColors.accentColor
                                    : Colors.red)

                        // TextStyle(
                        //     color: payment['status'] == "pending"
                        //         ? Colors.blue
                        //         : payment['status'] == "completed"
                        //             ? Colors.green
                        //             : Colors.red,
                        //     fontSize: 14.sp)
                        ),
                  ),
                ),
              );
            },
          );
  }
}

Widget swapButton({context, text, textColor, buttonColor, ontap}) {
  return Expanded(
    child: InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(text,
              style: AppTextStyles.adaptiveText(context, 15)
                  .copyWith(color: textColor)),
        ),
      ),
    ),
  );
}
