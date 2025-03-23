import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/admin/screens/deposit/deposit_records.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/admin//screens/withdraw/withdraw_records.dart';

class AdminTransactionScreen extends StatelessWidget {
  const AdminTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 12.h),
              child: Column(
                children: [
                  Header(
                      title: "Transactions",
                      ontap: () {
                        Get.back();
                      }),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => AdminDepositRecords());
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Deposit Records',
                                style: AppTextStyles.adaptiveText(context, 16)
                                    .copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.accentColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => WithdrawRecords());
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Withdraw Records',
                                style: AppTextStyles.adaptiveText(context, 16)
                                    .copyWith(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.accentColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
