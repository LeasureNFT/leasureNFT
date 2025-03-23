import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/admin/screens/admin_main_screen.dart';
import 'package:leasure_nft/app/auth_screens/sign_up_screen.dart';
import 'package:leasure_nft/app/root/controller/root_controller.dart';
import 'package:leasure_nft/app/auth_screens/user_login_screen.dart';
import 'package:leasure_nft/app/users/screens/dashboard/user_dashboard_screen.dart';
import 'package:universal_html/html.dart' as html; // For cookies

class RootScreen extends GetView<RootController> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Get `ref` from URL
    final String? refCode = Uri.base.queryParameters['ref'];

    // ✅ Save `ref` to cookies
    if (refCode != null) {
      html.window.document.cookie = "ref=$refCode";
    }

    return GetBuilder<RootController>(
      init: RootController(),
      builder: (controller) => Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (refCode != null) {
              // If ref is present in URL
              if (!snapshot.hasData) {
                // User not logged in → Redirect to signup
                return SignUpScreen();
              } else {
                // User already logged in → Show message
                return AlertDialog(
                  title: Text("Referral Code Detected"),
                  content: Text(
                      "You are already logged in. Referral codes can only be used by new users."),
                  actions: [
                    TextButton(
                      onPressed: () => Get.off(
                          snapshot.data!.email == "admin@gmail.com"
                              ? AdminMainScreen()
                              : UserDashboardScreen()),
                      child: Text("Continue to Dashboard"),
                    ),
                  ],
                );
              }
            }

            // ✅ Normal Firebase Auth check
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              final User? user = snapshot.data;
              if (user != null && user.email == "admin@gmail.com") {
                return AdminMainScreen();
              } else {
                return UserDashboardScreen();
              }
            } else {
              return UserLoginScreen();
            }
          },
        ),
      ),
    );
  }
}
