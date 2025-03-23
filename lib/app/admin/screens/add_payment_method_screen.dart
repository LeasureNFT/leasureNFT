import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/admin//controllers/add_payment_method_controller.dart';

class AddPaymentMethodScreen extends GetView<AddPaymentMethodController> {
  AddPaymentMethodScreen({super.key});
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPaymentMethodController>(
        init: AddPaymentMethodController(),
        builder: (controller) => Scaffold(
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Header(
                          title: "Payment Method",
                          ontap: () {
                            Get.back();
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        prefixIcon: Icons.account_balance,
                        hintText: "Enter Bank Name",
                        controller: controller.accountNameController,
                        title: "Bank Name",
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter Bank Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                          prefixIcon: Icons.numbers,
                          title: "Account Number",
                          controller: controller.accountNumberController,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Account Number";
                            } else {
                              return null;
                            }
                          },
                          hintText: "Enter Acount Number"),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        prefixIcon: Icons.account_box_rounded,
                        controller: controller.bankNameController,
                        hintText: "Enter Acount Holder Name",
                        title: "Account Holder Name",
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter Account Holder Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(
                        () => CustomButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                controller.addPaymentMethod();
                              }
                            },
                            loading: controller.isLoading.value,
                            text: "Add"),
                      )
                    ],
                  ),
                ),
              )),
            ));
  }
}
