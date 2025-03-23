import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/assets/app_images.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/auth_controllers/auth_controller_vendor.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';

class ForgetPaswordScreen extends GetView<ForgetPasswordController> {
  final formKey = GlobalKey<FormState>();
  ForgetPaswordScreen({super.key});

  Widget build(BuildContext context) {
    // Tablet detection

    return GetBuilder<ForgetPasswordController>(
        init: ForgetPasswordController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.back(),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: SizedBox(
                            height: 200.h,
                            child: Image.asset(AppImages.logo),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        // Dynamic spacing
                        Text('Reset Your Password',
                            style: AppTextStyles.adaptiveText(context, 20)
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.h),
                        Text(
                            "Don't worry if you forgot your password. Just enter your associated email here to get a password reset link.",
                            style: AppTextStyles.adaptiveText(context, 18)
                                .copyWith(fontWeight: FontWeight.w500)),
                        SizedBox(height: 25.h),

                        CustomTextField(
                          title: 'Email',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Email is required';
                            }
                            if (!v.isEmail) {
                              return 'Enter a Email';
                            }
                            return null;
                          },
                          controller: controller.emailController,
                          hintText: 'Enter your Email',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: 50.h),
                        Obx(
                          () => CustomButton(
                            loading: controller.isLoading.value,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                controller.resetmypassword();
                              }
                            },
                            text: 'Continue',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
