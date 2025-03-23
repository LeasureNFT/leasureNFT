import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/admin//controllers/payment_method_controller.dart';
import 'package:leasure_nft/app/routes/app_routes.dart';

class PaymentMethodsScreen extends GetView<PaymentMethodController> {
  const PaymentMethodsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodController>(
        init: PaymentMethodController(),
        builder: (controller) => Scaffold(
              floatingActionButton: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.addPaymentMethod);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: AppColors.primaryColor,
                  elevation: 5,
                ),
                child: Text(
                  "Add",
                  style: AppTextStyles.adaptiveText(context, 18).copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                child: Column(
                  children: [
                    Header(
                        title: "Payment Method",
                        ontap: () {
                          Get.back();
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
                                        // print(payment);
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
                                        ),
                                      ),
                                    );
                                  }),
                    )),
                  ],
                ),
              )),
            ));
  }
}
