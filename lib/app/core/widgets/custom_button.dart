import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';

class CustomButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  const CustomButton(
      {super.key,
      this.loading = false,
      required this.onPressed,
      required this.text,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h), // Adjust height
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.accentColor],
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child: loading
                ? CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                : Text(
                    text,
                    style: AppTextStyles.adaptiveText(context, 16).copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          )),
    );
  }
}
