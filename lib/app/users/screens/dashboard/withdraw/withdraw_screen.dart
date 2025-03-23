import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/users/contollers/user_main_controller.dart';
import 'package:leasure_nft/app/users/screens/dashboard/withdraw/controller/user_withdraw_controller.dart';

class WithdrawalScreen extends GetView<UserWithdrawController> {
  //

  WithdrawalScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserWithdrawController>(
        init: UserWithdrawController(),
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                        title: "Withdraw",
                        ontap: () {
                          final controller1 =
                              Get.find<UserDashboardController>();
                          controller1.changePage(DashboardTab.home.index);
                        }),
                    SizedBox(height: 20.h),

                    Obx(
                      () => Text(
                        'Balance : ${controller.cashVault.value}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Payment Method Dropdown
                    Obx(() => ClipRRect(
                          borderRadius:
                              BorderRadius.circular(15.r), // Border Radius
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors
                                  .transparent, // Remove top & bottom divider
                            ),
                            child: ExpansionTile(
                              key: GlobalKey(),
                              initiallyExpanded: false,
                              onExpansionChanged: (value) {},
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Border Radius
                              ),
                              title: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13.w, vertical: 5.h),
                                child: Text(
                                  controller.selectedPaymentMethod.value.isEmpty
                                      ? 'Select Bank'
                                      : controller.selectedPaymentMethod.value,
                                  style:
                                      AppTextStyles.adaptiveText(context, 16),
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.primaryColor,
                              ),
                              tilePadding: EdgeInsets.zero,
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.5),
                              collapsedBackgroundColor:
                                  AppColors.accentColor.withOpacity(0.2),
                              children: controller.isloading.value
                                  ? [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    ]
                                  : controller.paymentMethods.isEmpty
                                      ? [
                                          Center(
                                            child: Text("No Banks Found!",
                                                style:
                                                    AppTextStyles.adaptiveText(
                                                        context, 16)),
                                          )
                                        ]
                                      : controller.paymentMethods
                                          .map((method) => InkWell(
                                                onTap: () {
                                                  controller
                                                      .selectedPaymentMethod
                                                      .value = method;
                                                  Get.back(); // Close ExpansionTile
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 10.h),
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                                .selectedPaymentMethod
                                                                .value ==
                                                            method
                                                        ? AppColors.primaryColor
                                                        : AppColors.whiteColor,
                                                  ),
                                                  child: Text(
                                                    method,
                                                    style: AppTextStyles
                                                            .adaptiveText(
                                                                context, 16)
                                                        .copyWith(
                                                      color: controller
                                                                  .selectedPaymentMethod
                                                                  .value ==
                                                              method
                                                          ? AppColors.whiteColor
                                                          : AppColors
                                                              .blackColor,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                            ),
                          ),
                        )),

                    SizedBox(height: 16.h),

                    // Amount Field
                    CustomTextField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                      prefixIcon: Icons.currency_exchange_outlined,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: controller.amountController,
                      title: 'Amount',
                      hintText: 'Enter withdrawal amount',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.h),

                    // Account Number Field
                    CustomTextField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Please enter account number';
                        }
                        return null;
                      },
                      prefixIcon: Icons.numbers_outlined,
                      controller: controller.accountNumberController,
                      title: 'Account Number',
                      hintText: 'Enter account number',
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.h),

                    // Account Holder Name Field
                    CustomTextField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Please enter account holder name';
                        }
                        return null;
                      },
                      prefixIcon: Icons.person,
                      controller: controller.accountHolderNameController,
                      title: 'Account Holder Name',
                      hintText: 'Enter account holder name',
                    ),
                    SizedBox(height: 30.h),

                    // Submit Button
                    CustomButton(
                        onPressed: () async {
                          await controller.submitPayment();
                        },
                        text: "Withdraw")
                  ],
                ),
              ),
            ),
          );
        });
  }
}
