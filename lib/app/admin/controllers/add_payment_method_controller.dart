import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/admin//controllers/payment_method_controller.dart';
import 'package:leasure_nft/app/core/widgets/loading.dart';

class AddPaymentMethodController extends GetxController {
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  final paymentController = Get.find<PaymentMethodController>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPaymentMethod() async {
    try {
      isLoading.value = true;
      String accountName = accountNameController.text.trim();
      String accountNumber = accountNumberController.text.trim();
      String bankName = bankNameController.text.trim();
      CustomLoading.show();

      await firestore.collection("payment_method").doc().set({
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "timestamp": FieldValue.serverTimestamp(), // Adds current date/time
      });

      Fluttertoast.showToast(
          msg: "Payment method added successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      await paymentController.fetchPaymentMethods();
      Get.back();

      // Get.snackbar("Success", "Payment method added successfully!");
      accountNameController.clear();
      accountNumberController.clear();
      bankNameController.clear();
      isLoading.value = false;

      CustomLoading.hide();
    } catch (e) {
      Get.log("Error in add payment method $e");
      Fluttertoast.showToast(
          msg: "Error in add payment method $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } finally {
      CustomLoading.hide();
      isLoading.value = false;
    }
  }
}
