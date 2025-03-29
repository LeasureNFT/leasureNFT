import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:universal_html/html.dart' as html;

import 'package:leasure_nft/app/core/widgets/toas_message.dart';
import 'package:leasure_nft/app/routes/app_routes.dart';

class SignupController extends GetxController {
  var isObsure = true.obs;
  var isloding = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final refferalCodeController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    getReferralFromCookie();

    super.onInit();
  }

  void togglePasswordVisibility() {
    isObsure.value = !isObsure.value;
  }

  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? storedId = storage.read('deviceId');

    if (storedId == null) {
      if (GetPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        storedId = androidInfo.id;
      } else if (GetPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        storedId = iosInfo.identifierForVendor;
      } else if (GetPlatform.isWeb) {
        WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        storedId = webInfo.userAgent ?? 'unknown_web_device';
      } else {
        storedId = 'unknown_device';
      }
      storage.write('deviceId', storedId);
      if (kDebugMode) {
        print("[DEBUG] New Device ID generated: $storedId");
      }
    } else {
      if (kDebugMode) {
        print("[DEBUG] Existing Device ID found: $storedId");
      }
    }
    return storedId!;
  }

  void getReferralFromCookie() {
    if (kIsWeb) {
      final cookies = html.document.cookie?.split('; ') ?? [];
      for (var cookie in cookies) {
        final parts = cookie.split('=');
        if (parts.length == 2 && parts[0] == 'ref') {
          refferalCodeController.text = parts[1];
          break;
        }
      }
    }
  }

  Future<bool> canCreateAccount() async {
    String deviceId = await getDeviceId();
    if (kDebugMode) {
      print("[DEBUG] Checking device ID in Firestore: $deviceId");
    }

    final users = await firestore
        .collection('users')
        .where('deviceId', isEqualTo: deviceId)
        .get();

    if (kDebugMode) {
      print(
          "[DEBUG] Accounts found with this device ID: \${users.docs.length}");
    }
    return users.docs.length < 2;
  }

  Future<void> createUser() async {
    isloding.value = true;

    if (!await canCreateAccount()) {
      isloding.value = false;
      MessageToast.showToast(
          msg: 'You cannot create more than 2 accounts from this device');
      return;
    }

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        String deviceId = await getDeviceId();

        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': emailController.text.trim(),
          'userId': userCredential.user!.uid,
          'username': nameController.text.trim(),
          'password': passwordController.text.trim(),
          'depositAmount': '0',
          'withdrawAmount': '0',
          'reward': '0',
          'deviceId': deviceId,
          'cashVault': '0',
          "isUserBanned":false,
          'refferredBy': refferalCodeController.text.isEmpty
              ? ""
              : refferalCodeController.text,
          'refferralProfit': '0',
          'createdAt': FieldValue.serverTimestamp(),
          'image': ''
        });

        if (kDebugMode) {
          print("[DEBUG] New user created with device ID: $deviceId");
        }

        isloding.value = false;
        MessageToast.showToast(msg: 'Sign Up Successfully');
        Get.toNamed(AppRoutes.login);
      }
    } on FirebaseAuthException catch (e) {
      isloding.value = false;
      if (e.code == 'email-already-in-use') {
        MessageToast.showToast(msg: 'Email already in use');
      } else if (e.code == 'weak-password') {
        MessageToast.showToast(msg: 'Password is weak');
      } else if (e.code == 'invalid-email') {
        MessageToast.showToast(msg: 'Invalid Email');
      } else {
        MessageToast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      isloding.value = false;
      if (kDebugMode) {
        print("[ERROR] Exception during signup: $e");
      }
      MessageToast.showToast(msg: 'Something went wrong');
    }
  }
}
