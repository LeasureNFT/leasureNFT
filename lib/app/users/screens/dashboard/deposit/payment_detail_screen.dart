import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/core/widgets/toas_message.dart';
import 'package:leasure_nft/app/users/screens/dashboard/deposit/controller/deposit_controller.dart';

class PaymentDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot payment;
  final controller = Get.put(DepositController());
  final formkey = GlobalKey<FormState>();
  PaymentDetailScreen({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                      title: "Deposit Details",
                      ontap: () {
                        Get.back();
                      }),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text('Bank Payment Instruction:',
                      style: AppTextStyles.adaptiveText(context, 20).copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.accentColor, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: AppColors.whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Account Name: ',
                                style: AppTextStyles.adaptiveText(context, 15)
                                    .copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Text('${payment['accountName']}',
                                  style: AppTextStyles.adaptiveText(context, 17)
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.normal)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text('Account Number: ',
                                style: AppTextStyles.adaptiveText(context, 15)
                                    .copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text('${payment['accountNumber']}',
                                        style: AppTextStyles.adaptiveText(
                                                context, 17)
                                            .copyWith(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.normal)),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: payment['accountNumber']));

                                        MessageToast.showToast(
                                            msg: "Copied to clipboard");
                                      },
                                      child: Icon(
                                        Icons.copy,
                                        size: 15,
                                        applyTextScaling: true,
                                        color: AppColors.purpleColor,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text('Account Holder Name: ',
                                style: AppTextStyles.adaptiveText(context, 15)
                                    .copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Text('${payment['bankName']}',
                                  style: AppTextStyles.adaptiveText(context, 17)
                                      .copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.normal)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Gateway Name:',
                                style: AppTextStyles.adaptiveText(context, 18)
                                    .copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal)),
                            Text('${payment['accountName']}',
                                style: AppTextStyles.adaptiveText(context, 18)
                                    .copyWith(
                                        color: AppColors.accentColor,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amount:',
                                style: AppTextStyles.adaptiveText(context, 16)
                                    .copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal)),
                            Expanded(
                              child: Obx(
                                () => Text('${controller.amount.value} PKR',
                                    textAlign: TextAlign.end,
                                    style:
                                        AppTextStyles.adaptiveText(context, 18)
                                            .copyWith(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    hintText: "Enter Amount",
                    prefixIcon: Icons.request_page,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: controller.amountController,
                    onChanged: (v) {
                      controller.amount.value = v;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Amount is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Obx(() {
                      if (controller.base64Image.value.isNotEmpty) {
                        // Convert base64 string to bytes
                        Uint8List imageBytes =
                            base64Decode(controller.base64Image.value);
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            imageBytes,
                            fit: BoxFit.cover,
                            width: 300,
                            height: 300,
                          ),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file,
                              color: Colors.blueAccent,
                              size: 50,
                            ),
                            SizedBox(height: 10),
                            Text("No Image Selected"),
                          ],
                        );
                      }
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.pickCahalanImage();
                      },
                      icon: const Icon(
                        Icons.upload_file,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 12.w,
                        ),
                      ),
                      label: Obx(
                        () => Text(
                            controller.filePath.value == null
                                ? 'Upload File'
                                : 'Change File',
                            style: AppTextStyles.adaptiveText(context, 16)
                                .copyWith(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.normal)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Obx(
                    () => CustomButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            controller.submitPayment(
                                acName: payment['accountName'],
                                acNumber: payment['accountNumber'],
                                holdername: payment["bankName"],
                                paymentmethod: payment['accountName']);
                          }
                        },
                        loading: controller.isloading.value,
                        text: "Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
