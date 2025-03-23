import 'package:flutter/material.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const Header({super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(5),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.whiteColor,
                size: 20,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(title,
              textAlign: TextAlign.center,
              style: AppTextStyles.adaptiveText(context, 20).copyWith(
                  color: AppColors.blackColor, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
