

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLoading {
  static bool isProgressVisible = false;

  /// Show progress dialog
  static void show({bool isCancellable = false}) async {
    if (!isProgressVisible) {
      if (kDebugMode) {
        print("Showing loading...");
      }
      Get.dialog(
        Center(
          child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 4),
        ),
        barrierDismissible: isCancellable,
        useSafeArea: false,
      );
      isProgressVisible = true;
    }
  }

  /// Hide progress dialog
  static void hide() async {
    if (isProgressVisible) {
      await Future.delayed(Duration(milliseconds: 200));  // Ensures UI updates
      if (Get.isDialogOpen ?? false) {
        print("Closing dialog...");
        Get.back();
        await Future.delayed(Duration(milliseconds: 100)); // Wait for animation
        isProgressVisible = false;
      } else {
        print("No active dialog to close.");
      }
    }
  }
}
