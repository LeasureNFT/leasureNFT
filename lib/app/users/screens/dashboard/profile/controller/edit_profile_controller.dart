import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:leasure_nft/app/users/screens/dashboard/profile/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  final imgPicker = ImagePicker();
  RxString base64Image = ''.obs;
  var filePath = Rxn<File>();
  RxString profileImage = ''.obs;
  var password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  void fetchUserProfile() async {
    try {
      isLoading.value = true;
      String userId = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;

        nameController.text = data['username'] ?? '';
        emailController.text = data['email'] ?? '';
        password = data['password'] ?? '';

        base64Image.value = data['image'] ?? ''; // Base64 or empty string
      }
    } catch (e) {
      print("❌ Error fetching user profile: $e");
      Fluttertoast.showToast(msg: "❌ Error fetching profile");
    } finally {
      isLoading.value = false;
    }
  }

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
      print(
          "✅ Image Converted to Base64 (Size: ${compressedBytes.length} bytes)");
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
      img.Image resizedImage =
          img.copyResize(originalImage, width: 800); // Reduce width
      Uint8List compressedBytes =
          img.encodeJpg(resizedImage, quality: 70); // 70% quality

      print("📉 Image Compressed Successfully");
      return compressedBytes;
    } catch (e) {
      print("❌ Error compressing image: $e");
      return imageBytes; // Return original if compression fails
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      String userId = _auth.currentUser!.uid;
      User? user = _auth.currentUser;

      // Fetch current user data from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      String storedPassword =
          userDoc.get("password"); // Get stored password from Firestore

      // Update map to store fields that need updating

      // ✅ Check if old password is provided
      if (oldPasswordController.text.isNotEmpty) {
        if (oldPasswordController.text != storedPassword) {
          Fluttertoast.showToast(msg: "⚠ Old password is incorrect!");
          isLoading.value = false;
          return;
        }

        // ✅ If old password is correct, check new password fields
        if (passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty) {
          if (passwordController.text != confirmPasswordController.text) {
            Fluttertoast.showToast(
                msg: "⚠ New password and Confirm password do not match!");
            isLoading.value = false;
            return;
          }

          // ✅ Re-authenticate the user before updating the password

          await user?.updatePassword(
              passwordController.text); // Firebase Auth password update
          // Update password in Firestore
        }
      }

      // ✅ If only the username is updated

      // ✅ Update Firestore only if there's something to update

      await _firestore.collection('users').doc(userId).update({
        'username': nameController.text,
        'password': confirmPasswordController.text.isEmpty
            ? password
            : confirmPasswordController.text,
        'image': base64Image.value.isNotEmpty
            ? base64Image.value
            : profileImage.value,
      });
      Fluttertoast.showToast(msg: "✅ Profile Updated Successfully!");
      final profileController = Get.find<ProfileController>();
      profileController.listenToUserData();
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        Fluttertoast.showToast(
            msg: "⚠ Please log in again to update your password.");
      } else {
        print("❌ FirebaseAuth Error: $e");
        Fluttertoast.showToast(msg: "❌ Error: ${e.message}");
      }
    } catch (e) {
      print("❌ Error updating profile: $e");
      Fluttertoast.showToast(msg: "❌ Error updating profile.");
    } finally {
      isLoading.value = false;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }
}
