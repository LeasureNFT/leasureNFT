import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/users/contollers/user_main_controller.dart';
import 'package:leasure_nft/app/users/screens/dashboard/deposit/controller/deposit_controller.dart';
import 'package:leasure_nft/app/users/screens/dashboard/deposit/payment_detail_screen.dart';

class DepositScreen extends GetView<DepositController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
        init: DepositController(),
        builder: (controller) => Scaffold(
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
                child: Column(
                  children: [
                    Header(
                        title: "Select Payment Method",
                        ontap: () {
                          final controller1 =
                              Get.find<UserDashboardController>();
                          controller1.changePage(DashboardTab.home.index);
                        }),
                    SizedBox(height: 20.h),
                    Expanded(
                        child: Obx(
                      () => controller.isloading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.paymentMethods.isEmpty
                              ? Center(
                                  child: Text(
                                  "No payment methods Found!",
                                  style: AppTextStyles.adaptiveText(context, 14)
                                      .copyWith(
                                    color: AppColors.hintTextColor,
                                  ),
                                ))
                              : ListView.builder(
                                  itemCount: controller.paymentMethods.length,
                                  itemBuilder: (context, index) {
                                    final payment =
                                        controller.paymentMethods[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => PaymentDetailScreen(
                                              payment: payment,
                                            ));
                                        print(payment);
                                      },
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        margin: EdgeInsets.all(10),
                                        child: ListTile(
                                          title: Text(
                                            payment["accountName"],
                                            style: AppTextStyles.adaptiveText(
                                                    context, 18)
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Account Number: ${payment["accountNumber"]}",
                                                style:
                                                    AppTextStyles.adaptiveText(
                                                            context, 16)
                                                        .copyWith(
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                              Text(
                                                "Holder Name: ${payment["bankName"]}",
                                                style:
                                                    AppTextStyles.adaptiveText(
                                                            context, 16)
                                                        .copyWith(
                                                            color: AppColors
                                                                .accentColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(Icons
                                                .arrow_forward_ios_outlined),
                                            color: AppColors.blackColor,
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                    ))
                  ],
                ),
              )),
            ));
  }
}
