import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/constants.dart';
import 'package:leasure_nft/app/admin//controllers/transaction_details_controller.dart';

class TransactionDetailScreen extends GetView<TransactionDetailsController> {
  final QueryDocumentSnapshot transaction;
  final bool isFormAmin;

  const TransactionDetailScreen(
      {super.key, required this.transaction, this.isFormAmin = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionDetailsController>(
        init: TransactionDetailsController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
                child: Column(
                  children: [
                    Header(
                        title: "Transaction Details",
                        ontap: () {
                          Get.back();
                        }),
                    SizedBox(height: 20.h),
                    Text("Transaction ID:  ${transaction['transactionId']}",
                        style: AppTextStyles.adaptiveText(context, 25).copyWith(
                            color: AppColors.accentColor,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Account Name:",
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        Text(transaction['accountName']!,
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Holder Name:",
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        Text(transaction['holderName'],
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount:",
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        Text(transaction['amount']!,
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date:",
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        Text(
                            controller
                                .formatTimestamp(transaction['createdAt']),
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Type:",
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        Text(transaction['transactionType']!,
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status:",
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        Text(transaction['status']!,
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.darkBlack,
                                    fontWeight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const Divider(thickness: 1, color: Colors.grey),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total",
                            style: AppTextStyles.adaptiveText(context, 18)
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold)),
                        Text("Rs ${transaction['amount']}",
                            style: AppTextStyles.adaptiveText(context, 18)
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                    if (isFormAmin) ...[
                      transaction['transactionType'] == "Deposit"
                          ? Center(
                              child: SizedBox(
                                height: 200.h,
                                child: Image.memory(
                                  base64Decode(transaction['filePath']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SizedBox(),
                      const SizedBox(height: 20),
                      transaction['status'] == "pending"
                          ? Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Obx(
                                      () => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 30),
                                        ),
                                        onPressed: () {
                                          transaction['transactionType'] ==
                                                  "Deposit"
                                              ? controller.confirmDeposit(
                                                  userId: transaction["userId"],
                                                  docId: transaction.id,
                                                  amount: transaction["amount"],
                                                )
                                              : controller.confirmWithdraw(
                                                  userId: transaction["userId"],
                                                  docId: transaction.id,
                                                  amount: transaction["amount"],
                                                );
                                        },
                                        child: controller.isLoading.value
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                "Confirm",
                                                style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Obx(
                                      () => ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 30),
                                        ),
                                        onPressed: () async {
                                          await controller.cancel(
                                              docId: transaction.id);
                                        },
                                        child: controller.isLoading1.value
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                "Cancel",
                                                style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : CustomButton(
                              onPressed: () {
                                Get.back();
                              },
                              text: "Done"),
                    ] else ...[
                      CustomButton(
                          onPressed: () {
                            Get.back();
                          },
                          text: "Done")
                    ]
                  ],
                ),
              ),
            ),
          );
        });
  }
}
