import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/app_textstyle.dart';
import 'package:leasure_nft/app/core/widgets/header.dart';
import 'package:leasure_nft/app/users/screens/network/controller/network_controller.dart';

class NetworkScreen extends GetView<NetworkController> {
  const NetworkScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkController>(
        init: NetworkController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 16.h),
                child: Column(
                  children: [
                    Header(
                        title: "Network",
                        ontap: () {
                          Get.back();
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: Obx(() {
                        if (controller.isloading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (controller.referralTree.isEmpty) {
                          return Center(child: Text("No referrals yet"));
                        } else {
                          return SingleChildScrollView(
                            child: TreeView(
                              treeController: controller.treeController,
                              indent: 20.0,
                              iconSize: 25,
                              nodes: _buildTreeNodes(
                                  controller.referralTree, context),
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  /// Recursively build tree nodes
  List<TreeNode> _buildTreeNodes(
      List<Map<String, dynamic>> referrals, context) {
    return referrals.map((referral) {
      return TreeNode(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.accentColor),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.person, color: AppColors.primaryColor),
              SizedBox(width: 10),
              Text(referral["name"],
                  style: AppTextStyles.adaptiveText(context, 15)),
            ],
          ),
        ),
        children: _buildTreeNodes(referral["children"], context),
      );
    }).toList();
  }
}
