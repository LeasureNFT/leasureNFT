import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/widgets/loading.dart';
import 'package:leasure_nft/app/core/widgets/toas_message.dart';

class UserWithdrawController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderNameController =
      TextEditingController();

  var cashVault = 0.0.obs;
  var isloading = false.obs;
  RxString selectedPaymentMethod = ''.obs;
  RxList<String> paymentMethods = <String>[
    'Easypaisa - Telenor Microfinance Bank',
    'JazzCash - Mobilink Microfinance Bank',
    'Habib Bank Limited (HBL)',
    'Allied Bank Limited (ABL)',
    'Meezan Bank Limited',
    'United Bank Limited (UBL)',
    'Muslim Commercial Bank Limited (MCB)',
    'Faysal Bank Limited',
    'Bank Alfalah Limited',
    'Standard Chartered Bank Pakistan Limited',
    'SadaPay',
    'NayaPay',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCashVault();
    // getPaymentMethods();
  }

  String generateTransactionId() {
    Random random = Random();
    int transactionId = random.nextInt(90000) + 10000; // 10000 to 99999
    return transactionId.toString();
  }

  void fetchCashVault() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        cashVault.value = userDoc['cashVault'] ?? 0;
      }
    } catch (e) {
      print("Error fetching cashVault: $e");
    }
  }

  // Future<void> getPaymentMethods() async {
  //   try {
  //     isloading.value = true;
  //     QuerySnapshot querySnapshot =
  //         await FirebaseFirestore.instance.collection('payment_method').get();
  //     paymentMethods.value = querySnapshot.docs
  //         .map((doc) => doc['accountName'].toString())
  //         .toList();
  //     isloading.value = false;
  //   } catch (e) {
  //     print('Error fetching payment methods: $e');
  //   } finally {
  //     isloading.value = false;
  //   }
  // }

  Future<void> submitPayment() async {
    try {
      if (selectedPaymentMethod.value.isEmpty) {
        MessageToast.showToast(msg: "Please select a payment method");

        return;
      }
      if (amountController.text.trim().isEmpty) {
        MessageToast.showToast(msg: "Please enter amount");

        return;
      }
      if (accountNumberController.text.trim().isEmpty) {
        MessageToast.showToast(msg: "Please enter account number");

        return;
      }
      if (accountHolderNameController.text.trim().isEmpty) {
        MessageToast.showToast(msg: "Please enter account holder name");

        return;
      }
      isloading.value = true;

      final user_id = FirebaseAuth.instance.currentUser!.uid;

      if (cashVault.value < 500) {
        CustomLoading.hide();
        MessageToast.showToast(
          msg: "Your Balance is less than 500",
        );

        isloading.value = false;
        return;
      }

      await FirebaseFirestore.instance.collection('payments').doc().set({
        "userId": user_id,
        "transactionId": generateTransactionId(),
        'payment_method': selectedPaymentMethod.value,
        'accountName': selectedPaymentMethod.value,
        'accountNumber': accountNumberController.text.trim(),
        "transactionType": "Withdraw",
        "holderName": accountHolderNameController.text.trim(),
        'amount': amountController.text.trim(),
        'status': 'pending',
        "createdAt": FieldValue.serverTimestamp(),
      }).then((value) {
        Get.back();
        Fluttertoast.showToast(
          msg: "Withdraw Request Sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        isloading.value = false;
      });

      amountController.clear();
      accountHolderNameController.clear();
      accountNumberController.clear();
      selectedPaymentMethod.value = '';
    } catch (e) {
      isloading.value = false;
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.log(e.toString());
    }
  }
}
