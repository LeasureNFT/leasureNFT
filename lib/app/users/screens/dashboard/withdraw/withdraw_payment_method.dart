// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:leasure_nft/app/core/widgets/header.dart';
// import 'package:leasure_nft/app/users/screens/dashboard/deposit/controller/deposit_controller.dart';
// import 'package:leasure_nft/app/users/screens/dashboard/withdraw/withdraw_screen.dart';

// class WithdrawPaymentMethod extends GetView<DepositController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DepositController>(
//         init: DepositController(),
//         builder: (controller) => Scaffold(

//               body: SafeArea(
//                   child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
//                 child: Column(
//                   children: [
//                     Header(title: "title", ontap: ontap)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'List of payment methods',
//                           style: GoogleFonts.inter(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16.sp,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.h),
//                     Expanded(
//                         child: Obx(
//                       () => controller.isloading.value
//                           ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : controller.paymentMethods.isEmpty
//                               ? Center(
//                                   child: Text("No payment methods Found!"),
//                                 )
//                               : ListView.builder(
//                                   itemCount: controller.paymentMethods.length,
//                                   itemBuilder: (context, index) {
//                                     final payment =
//                                         controller.paymentMethods[index];
//                                     return InkWell(
//                                       onTap: () {
//                                         Get.to(() => WithdrawalScreen(
//                                               payment: payment,
//                                             ));
//                                         // print(payment);
//                                       },
//                                       child: Card(
//                                         elevation: 5,
//                                         color: Colors.white,
//                                         margin: EdgeInsets.all(10),
//                                         child: ListTile(
//                                           title: Text(payment["accountName"]),
//                                           subtitle: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                   "Account Number: ${payment["accountNumber"]}"),
//                                               Text(
//                                                   "Holder Name: ${payment["bankName"]}"),
//                                             ],
//                                           ),
//                                           trailing: IconButton(
//                                             icon: Icon(Icons
//                                                 .arrow_forward_ios_outlined),
//                                             color: Colors.black,
//                                             onPressed: () {},
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }),
//                     ))
//                   ],
//                 ),
//               )),
//             ));
//   }
// }
