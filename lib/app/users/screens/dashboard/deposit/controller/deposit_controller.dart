import 'dart:convert';
import 'dart:io';
import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
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
  try {
    final XFile? img = await imgPicker.pickImage(source: ImageSource.gallery);

    if (img == null) {
      print("⚠ No Image Selected");
      return;
    }

    Uint8List imageBytes;

    if (GetPlatform.isWeb) {
      // Web: Directly read image bytes
      imageBytes = await img.readAsBytes();
      print("🌐 Running on Web");
    } else {
      // Mobile/Desktop: Read file from path
      filePath.value = File(img.path);
      imageBytes = await filePath.value!.readAsBytes();
      print("📱 Running on Mobile/Desktop");
    }

    // 🔹 Compress Image Before Base64 Encoding
    Uint8List compressedBytes = await compressImage(imageBytes);

    // Convert to Base64
    base64Image.value = base64Encode(compressedBytes);
    print("✅ Image Converted to Base64 (Size: ${compressedBytes.length} bytes)");

  } catch (e) {
    print("❌ Error picking image: $e");
  }
}

// 🔥 Image Compression Function
Future<Uint8List> compressImage(Uint8List imageBytes) async {
  try {
    img.Image? originalImage = img.decodeImage(imageBytes);
    if (originalImage == null) {
      print("⚠ Failed to decode image");
      return imageBytes;
    }

    // Resize & Compress Image
    img.Image resizedImage = img.copyResize(originalImage, width: 800); // Reduce width
    Uint8List compressedBytes = img.encodeJpg(resizedImage, quality: 70); // 70% quality

    print("📉 Image Compressed Successfully");
    return compressedBytes;
  } catch (e) {
    print("❌ Error compressing image: $e");
    return imageBytes; // Return original if compression fails
  }
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

  void submitPayment({acName, acNumber, paymentmethod, holdername}) async {
    try {
      isloading.value = true;
      final userId = FirebaseAuth.instance.currentUser!.uid;

      Get.log(base64Image.toString());

      if (base64Image.value.isEmpty) {
       
        // ✅ Corrected Condition
        Fluttertoast.showToast(
            msg: "❌ No Image Selected!", backgroundColor: Colors.red);
        isloading.value = false;
        return;
      }

      await FirebaseFirestore.instance.collection('payments').doc().set({
        "userId": userId,
        "transactionId": generateTransactionId(),
        'payment_method': paymentmethod,
        'accountName': acName,
        'accountNumber': acNumber,
        "transactionType": "Deposit",
        "holderName": holdername,
        'amount': amountController.text..trim(),
        'filePath': base64Image.value,
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
      }).onError((e, _) {
        isloading.value = false;
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
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
    } finally {
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
