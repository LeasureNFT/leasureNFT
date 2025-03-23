import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;

  final bool obscureText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final bool readOnly;
  final String? title;

  const CustomTextField({
    Key? key,
    this.title,
    this.controller,
    this.readOnly = false,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.suffixIcon,
    required this.prefixIcon,
    this.validator,
    this.inputFormatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width and height

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: AppTextStyles.adaptiveText(context, 15)
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          )
        ],
        TextFormField(
          readOnly: readOnly,
          validator: validator,
          controller: controller,
          inputFormatters: inputFormatter,
          obscureText: obscureText,
          cursorColor: kPrimaryColor,
          style: AppTextStyles.adaptiveText(context, 15)
              .copyWith(fontWeight: FontWeight.normal),

          // Adjust font size for tablet
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h, // Adjust padding for tablets
              horizontal: 16.w, // Horizontal padding
            ),
            filled: true,
            fillColor: AppColors.accentColor.withOpacity(0.1),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.redAccent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.redAccent,
              ),
            ),
            hintStyle: AppTextStyles.adaptiveText(context, 15)
                .copyWith(color: AppColors.hintTextColor),
            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.primaryColor,
            ),
            suffixIcon: suffixIcon,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
