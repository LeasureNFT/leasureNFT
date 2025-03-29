import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/core/widgets/toas_message.dart';
import 'package:leasure_nft/constants.dart';
import 'package:leasure_nft/app/admin//controllers/transaction_details_controller.dart';

class TransactionDetailScreen extends GetView<TransactionDetailsController> {
  final Map<String, dynamic> transaction;
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
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
                  child: Column(
                    children: [
                      Header(
                          title: "Transaction Details",
                          ontap: () {
                            Get.back();
                          }),
                      SizedBox(height: 20.h),
                      Text("Transaction ID:  ${transaction['transactionId']}",
                          style: AppTextStyles.adaptiveText(context, 25)
                              .copyWith(
                                  color: AppColors.accentColor,
                                  fontWeight: FontWeight.bold)),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account Number:",
                              style: AppTextStyles.adaptiveText(context, 16)
                                  .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(transaction['accountNumber']!,
                                    style:
                                        AppTextStyles.adaptiveText(context, 16)
                                            .copyWith(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text: transaction['accountNumber']));

                                      MessageToast.showToast(
                                          msg: "Copied to clipboard");
                                    },
                                    child: Icon(
                                      Icons.copy,
                                      size: 18,
                                      applyTextScaling: true,
                                      color: AppColors.blackColor,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account Name:",
                              style: AppTextStyles.adaptiveText(context, 16)
                                  .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                          VerticalDivider(),
                          Expanded(
                            child: Text(transaction['accountName']!,
                                textAlign: TextAlign.end,
                                style: AppTextStyles.adaptiveText(context, 16)
                                    .copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal)),
                          ),
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
                          Text("Rs ${transaction['amount']}",
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

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("User Name",
                              style: AppTextStyles.adaptiveText(context, 16)
                                  .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                          Text(transaction['username'],
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
                          Text("User Email",
                              style: AppTextStyles.adaptiveText(context, 16)
                                  .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                          Text(transaction['email'],
                              style: AppTextStyles.adaptiveText(context, 16)
                                  .copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.normal)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Divider(thickness: 1, color: Colors.grey),

                      const SizedBox(height: 10),
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
                                          onPressed: () async {
                                            transaction['transactionType'] ==
                                                    "Deposit"
                                                ? controller.confirmDeposit(
                                                    userId:
                                                        transaction["userId"],
                                                    docId: transaction["id"],
                                                    amount:
                                                        transaction["amount"],
                                                  )
                                                : await controller
                                                    .confirmWithdraw(
                                                    userId:
                                                        transaction["userId"],
                                                    docId: transaction["id"],
                                                    amount:
                                                        transaction["amount"],
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
                                              docId: transaction["id"],
                                            );
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
            ),
          );
        });
  }
}
