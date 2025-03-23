import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/toas_message.dart';
import 'package:leasure_nft/app/users/contollers/user_main_controller.dart';
import 'package:leasure_nft/app/users/screens/network/network_screen.dart';
import 'package:leasure_nft/app/users/screens/records/record_screen.dart';

class UserMainScreen extends GetView<UserDashboardController> {
  const UserMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDashboardController>(
        init: UserDashboardController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                  child: Obx(
                    () => controller.isloading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : Column(
                            children: [
                              // Gradient Header
                              Obx(
                                () => Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 30.r,
                                        backgroundColor: AppColors.accentColor
                                            .withOpacity(0.5),
                                        child: controller.userModel.value
                                                        ?.image !=
                                                    null &&
                                                controller.userModel.value!
                                                    .image!.isNotEmpty
                                            ? ClipOval(
                                                child: Image.memory(
                                                  base64Decode(controller
                                                      .userModel.value!.image!),
                                                  width: 160
                                                      .r, // Should match the diameter (2 * radius)
                                                  height: 160.r,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : Icon(
                                                Icons.person,
                                                size: 45,
                                                color: AppColors.primaryColor,
                                              )),
                                    VerticalDivider(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () => Text(
                                              controller.userModel.value
                                                      ?.username ??
                                                  "No Name",
                                              style: AppTextStyles.adaptiveText(
                                                      context, 18)
                                                  .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ),
                                        Obx(
                                          () => Text(
                                              controller
                                                      .userModel.value?.email ??
                                                  "No Email",
                                              style: AppTextStyles.adaptiveText(
                                                      context, 15)
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: AppColors
                                                          .hintTextColor)),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => RecordScreen());
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.history,
                                            color: AppColors.primaryColor,
                                          ),
                                          Text("Records",
                                              style: AppTextStyles.adaptiveText(
                                                      context, 14)
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              // Cards Section
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primaryColor,
                                      AppColors.accentColor
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 12.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Cash Vault",
                                                  style: AppTextStyles
                                                          .adaptiveText(
                                                              context, 20)
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                              SizedBox(height: 10.h),
                                              Obx(
                                                () => Text(
                                                    'Rs ${controller.userModel.value?.cashVault ?? 0}',
                                                    style: AppTextStyles
                                                            .adaptiveText(
                                                                context,
                                                                25)
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white)),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Icon(Icons.account_balance,
                                              size: 40.r, color: Colors.white),
                                        ],
                                      ),
                                      SizedBox(height: 18.h),
                                      Text("Refferal Link:",
                                          style: AppTextStyles.adaptiveText(
                                                  context, 14)
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.accentColor)),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Obx(
                                              () =>
                                                  controller.userModel.value ==
                                                          null
                                                      ? Text("Loading...",
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))
                                                      : Text(
                                                          'https://leasure-nft-88aaf.web.app/?ref=${controller.userModel.value!.userId}',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                            ),
                                          ),
                                          Obx(
                                            () => controller.userModel.value ==
                                                    null
                                                ? SizedBox()
                                                : IconButton(
                                                    onPressed: () {
                                                      Clipboard.setData(
                                                              ClipboardData(
                                                                  text:
                                                                      'https://leasure-nft-88aaf.web.app/?ref=${controller.userModel.value!.userId ?? ""}'))
                                                          .then((_) {
                                                        MessageToast.showToast(
                                                            msg:
                                                                "Link copied to clipboard");
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.copy,
                                                      color: AppColors
                                                          .primaryColor,
                                                    )),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 20.h),

                              Obx(
                                () => _card(
                                    iconPath: Icons.input,
                                    context: context,
                                    text1: "Total Deposit",
                                    text2:
                                        "Rs ${controller.userModel.value?.depositAmount ?? 0}",
                                    ontap: () {}),
                              ),
                              SizedBox(height: 10.h),
                              Obx(
                                () => _card(
                                    iconPath:
                                        Icons.account_balance_wallet_outlined,
                                    context: context,
                                    text1: "Total Withdraw",
                                    text2:
                                        "Rs ${controller.userModel.value?.withdrawAmount ?? 0}",
                                    ontap: () {}),
                              ),
                              SizedBox(height: 10.h),

                              Obx(
                                () => _card(
                                    iconPath: Icons.monetization_on_outlined,
                                    context: context,
                                    text1: "Total Bounce",
                                    text2:
                                        "Rs ${controller.userModel.value?.reward ?? 0}",
                                    ontap: () {}),
                              ),
                              SizedBox(height: 10.h),

                              Obx(
                                () => _card(
                                    iconPath: Icons.align_vertical_bottom_sharp,
                                    context: context,
                                    text1: "Total Profit",
                                    text2:
                                        "Rs ${controller.userModel.value?.refferralProfit!.toStringAsFixed(2)}",
                                    ontap: () {}),
                              ),
                              SizedBox(height: 10.h),
                              Obx(
                                () => _card(
                                    iconPath: Icons.pending_outlined,
                                    context: context,
                                    text1: "Pending Deposit",
                                    text2:
                                        "Rs ${controller.pendingAmount.value}",
                                    ontap: () {}),
                              ),
                              SizedBox(height: 10.h),
                              Obx(
                                () => _card(
                                    iconPath: Icons.group_sharp,
                                    context: context,
                                    text1: "Total Refferal",
                                    text2: "${controller.totalRefferral.value}",
                                    ontap: () {
                                      Get.to(() => NetworkScreen());
                                    }),
                              ),
                              SizedBox(height: 10.h),
                              Obx(
                                () => _card(
                                    iconPath: Icons.groups,
                                    context: context,
                                    text1: "Referral Earn",
                                    text2:
                                        "Rs ${controller.refferralProfit.value}",
                                    ontap: () {}),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  // Widget _buildBalanceCardRow(List<Widget> cards) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: cards,
  //   );
  // }

  // Widget _buildCard(String title, String value, IconData icon,
  //     double screenWidth, double screenHeight,
  //     {ontap}) {
  //   return Expanded(
  //     child: InkWell(
  //       onTap: ontap,
  //       child: Card(
  //         color: AppColors.primaryColor,
  //         elevation: 4,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //         child: Padding(
  //           padding: EdgeInsets.all(screenWidth * 0.03),
  //           child: Column(
  //             children: [
  //               Icon(icon, size: screenWidth * 0.07, color: Colors.white),
  //               SizedBox(height: screenHeight * 0.01),
  //               Text(title,
  //                   style: GoogleFonts.inter(
  //                       fontSize: screenWidth * 0.034,
  //                       fontWeight: FontWeight.w500,
  //                       color: Colors.white)),
  //               SizedBox(height: screenHeight * 0.005),
  //               Text(value,
  //                   style: GoogleFonts.inter(
  //                       fontSize: screenWidth * 0.028, color: Colors.white)),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildCardforDeposit(String title, String value, IconData icon,
  //     double screenWidth, double screenHeight,
  //     {ontap}) {
  //   return Expanded(
  //       child: InkWell(
  //     onTap: ontap,
  //     child: Padding(
  //         padding: EdgeInsets.all(screenWidth * 0.02),
  //         child: Column(
  //           children: [
  //             Icon(icon, size: screenWidth * 0.06, color: Colors.white),
  //             SizedBox(height: screenHeight * 0.01),
  //             Text(title,
  //                 style: GoogleFonts.inter(
  //                     fontSize: screenWidth * 0.035,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.white)),
  //             SizedBox(height: screenHeight * 0.005),
  //             Text(value,
  //                 style: GoogleFonts.inter(
  //                     fontSize: screenWidth * 0.03, color: Colors.white)),
  //           ],
  //         )),
  //   ));
  // }

  Widget _card({context, text1, text2, ontap, iconPath}) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                iconPath,
                color: AppColors.accentColor,
                size: 25.r,
              ),
              VerticalDivider(),
              Expanded(
                child: Text(
                  text1,
                  style: AppTextStyles.adaptiveText(context, 16).copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  text2,
                  textAlign: TextAlign.end,
                  style: AppTextStyles.adaptiveText(context, 16).copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
