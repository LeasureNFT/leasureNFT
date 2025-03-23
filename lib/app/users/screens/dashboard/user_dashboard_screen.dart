import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/users/contollers/user_main_controller.dart';
import 'package:leasure_nft/app/users/screens/dashboard/deposit/deposit_screen.dart';
import 'package:leasure_nft/app/users/screens/dashboard/main_screen.dart';
import 'package:leasure_nft/app/users/screens/dashboard/profile/profile_screen.dart';
import 'package:leasure_nft/app/users/screens/dashboard/task/user_task_screen.dart';
import 'package:leasure_nft/app/users/screens/dashboard/withdraw/withdraw_screen.dart';

class UserDashboardScreen extends GetView<UserDashboardController> {
  UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDashboardController>(
      init: UserDashboardController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.changePage(index);
            },
            itemCount: DashboardTab.values.length,
            physics: NeverScrollableScrollPhysics(), // Disable swipe
            itemBuilder: (context, index) {
              switch (DashboardTab.values[index]) {
                case DashboardTab.deposit:
                  return DepositScreen();
                case DashboardTab.task:
                  return UserTaskScreen();
                case DashboardTab.home:
                  return const UserMainScreen();
                case DashboardTab.withdraw:
                  return WithdrawalScreen();
                case DashboardTab.profile:
                  return UserProfileScreen();
              }
            },
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border(
                top: BorderSide(
                  color: AppColors.accentColor,
                  width: 8.h,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor300.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: DashboardTab.values.map((tab) {
                  int index = tab.index;
                  return _bottomNavItem(
                    context: context,
                    text: tab.name.capitalizeFirst!,
                    icon: _getIconForTab(tab),
                    isSelected: controller.currentIndex.value == index,
                    onTap: () {
                      controller.changePage(index);
                      controller.pageController.jumpToPage(index);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomNavItem({
    required BuildContext context,
    required String text,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.hintTextColor),
          Text(
            text,
            style: AppTextStyles.adaptiveText(context, 14).copyWith(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.hintTextColor),
          ),
        ],
      ),
    );
  }

  IconData _getIconForTab(DashboardTab tab) {
    switch (tab) {
      case DashboardTab.deposit:
        return Icons.attach_money_rounded;
      case DashboardTab.task:
        return Icons.notes_outlined;
      case DashboardTab.home:
        return Icons.dashboard_outlined;
      case DashboardTab.withdraw:
        return Icons.account_balance_wallet_outlined;
      case DashboardTab.profile:
        return Icons.person_3_outlined;
    }
  }
}
