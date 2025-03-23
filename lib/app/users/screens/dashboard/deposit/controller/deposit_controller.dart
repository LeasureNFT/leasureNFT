import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DepositController extends GetxController {
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

  RxString base64Image = ''.obs;
  var filePath = Rxn<File>();
  final imgPicker = ImagePicker();
  final amountController = TextEditingController();
  final amount = "0".obs;

  pickCahalanImage() async {
    final img = await imgPicker.pickImage(
      source: ImageSource.gallery,
    );

    try {
      if (img != null) {
        filePath.value = File(img.path);
        List<int> imageBytes =
            await filePath.value!.readAsBytes(); // Read Image Bytes
        String base64String = base64Encode(imageBytes); // Convert to Base64

        base64Image.value = base64String;
        print("✅ Image Converted to Base64");
      } else {
        print("⚠ No Image Selected");
      }
    } catch (e) {
      print("❌ Error picking image: $e");
    }
    update();
  }

  String generateTransactionId() {
  Random random = Random();
  int transactionId = random.nextInt(90000) + 10000; // 10000 to 99999
  return transactionId.toString();
}

  // Future<String?> uploadImages(File file) async {
  //   // String uid = FirebaseAuth.instance.currentUser!.uid;
  //   FirebaseStorage storage = FirebaseStorage.instance;

  //   String uniqueId = generateUniqueId();
  //   String filePath = "documents/$uniqueId/${file.path.split('/').last}";
  //   CustomLoading.show();

  //   await storage.ref(filePath).putFile(file);
  //   var url = await storage.ref(filePath).getDownloadURL();
  //   CustomLoading.hide();
  //   // profileDownloadURL = url;
  //   return url;
  // }

  void submitPayment({acName, acNumber, paymentmethod , holdername}) async {
    try {
  isloading.value = true; 
      final user_id = FirebaseAuth.instance.currentUser!.uid;

      String? base64String =
          base64Image.value.isNotEmpty ? base64Image.value : null;

      if (base64String == null) {
        Fluttertoast.showToast(
            msg: "❌ No Image Selected!", backgroundColor: Colors.red);
        return;
      }

      await FirebaseFirestore.instance.collection('payments').doc().set({
        "userId": user_id,
        "transactionId":generateTransactionId(),
        'payment_method': paymentmethod,
        'accountName': acName,
        'accountNumber': acNumber,
        "transactionType":"Deposit",
        "holderName":holdername,
        'amount': amountController.text..trim(),
        'filePath': base64String,
        'status': 'pending',
        "createdAt": FieldValue.serverTimestamp(),
      }).then((value) {
        // _verifyPhoneNumber();
isloading.value = false;
       Get.back();
      
        Fluttertoast.showToast(
          msg: "Deposit Request Sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
       
      amountController.clear();
      filePath.value = null;
      //  Continue with further logic
    } catch (e) {
      isloading.value = false;
      if (e is FirebaseAuthException) {
        Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('Error: $e');
      }
    }finally{
      isloading.value = false;
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
      isloading.value = false;
    }
  }
}
