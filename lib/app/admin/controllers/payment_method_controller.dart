import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/widgets/loading.dart';

class PaymentMethodController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<QueryDocumentSnapshot> paymentMethods = <QueryDocumentSnapshot>[].obs;
  var isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchPaymentMethods();
    }); // Fetch data when controller is initialized
  }

  void deletePaymentMethod(String id) async {
    try {
      CustomLoading.show();

      await firestore.collection("payment_method").doc(id).delete();

      Fluttertoast.showToast(msg: "Payment method deleted successfully");

      await fetchPaymentMethods();
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to delete payment method: $e");
      Get.log("Failed to delete payment method: $e");
    } finally {
      CustomLoading.hide();
    }
  }

  Future<void> fetchPaymentMethods() async {
    try {
      isloading.value = true;
      paymentMethods.clear();
      await FirebaseFirestore.instance
          .collection("payment_method")
          .get()
          .then((value) {
        for (var element in value.docs) {
          paymentMethods.add(element);
        }
        isloading.value = false;
      });

      // paymentMethods.value = querySnapshot.docs.map((doc) {
      //   return {
      //     "id": doc.id,
      //     "accountName": doc["accountName"],
      //     "accountNumber": doc["accountNumber"],
      //     "bankName": doc["bankName"],
      //     "timestamp": doc["timestamp"],
      //   };
      // }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch payment methods: ${e.toString()}");
    } finally {
      CustomLoading.hide();
    }
  }
}
