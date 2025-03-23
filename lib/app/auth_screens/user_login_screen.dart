import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/auth_controllers/login_controller.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/assets/app_images.dart';
import 'package:leasure_nft/app/core/widgets/custom_button.dart';
import 'package:leasure_nft/app/routes/app_routes.dart';
import 'package:leasure_nft/constants.dart';
import 'package:leasure_nft/app/core/widgets/custom_text_field.dart';

class UserLoginScreen extends GetView<LoginController> {
  UserLoginScreen({super.key});
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) => Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                          child: SizedBox(
                            height: 200.h,
                            child: Image.asset(AppImages.logo),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        // Dynamic spacing
                        Text('Welcome Back',
                            style: AppTextStyles.adaptiveText(context, 20)
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.h),
                        Text('Please Enter Your Details.',
                            style: AppTextStyles.adaptiveText(context, 18)
                                .copyWith(fontWeight: FontWeight.w500)),
                        SizedBox(height: 30.h),

                        CustomTextField(
                          title: 'Email',
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Email is required';
                            }
                            if (!v.isEmail) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          controller: controller.emailController,
                          hintText: 'Enter your email',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 15.h),

                        Obx(
                          () => CustomTextField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Password is required';
                              } else if (v.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            title: 'Password',
                            controller: controller.passwordController,
                            hintText: 'Enter your password',
                            prefixIcon: Icons.lock,
                            obscureText: controller.obscurePassword.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: kPrimaryColor,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),
                        SizedBox(height: 17.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.forgetPassword);
                              },
                              child: SizedBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text('Forgot password!',
                                      style: AppTextStyles.adaptiveText(
                                              context, 14)
                                          .copyWith(
                                              fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 50.h),
                        Obx(
                          () => CustomButton(
                            loading: controller.isLoading.value,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                controller.loginUser();
                              }
                            },
                            text: 'Login',
                          ),
                        ),
                        SizedBox(height: 30.h),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.signUp);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don’t have an account? ',
                                  style: AppTextStyles.adaptiveText(context, 14)
                                      .copyWith(fontWeight: FontWeight.w500)),
                              Text('Sign Up',
                                  style: AppTextStyles.adaptiveText(context, 14)
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
