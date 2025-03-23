// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:app_links/app_links.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:leasure_nft/app/auth_screens/sign_up_screen.dart';
// import 'package:leasure_nft/app/auth_screens/user_login_screen.dart';
// import 'package:leasure_nft/app/users/screens/dashboard/user_dashboard_screen.dart';

// class AuthGate extends StatefulWidget {
//   const AuthGate({super.key});

//   @override
//   State<AuthGate> createState() => _AuthGateState();
// }

// class _AuthGateState extends State<AuthGate> {
//   String? referralCode;
//   bool isFromReferral = false; // Track if user came from referral

//   @override
//   void initState() {
//     super.initState();
//     _handleDeepLinks();
//   }

//   void _handleDeepLinks() async {
//     final AppLinks appLinks = AppLinks();

//     // Listen for deep links while app is running
//     appLinks.uriLinkStream.listen((Uri? uri) {
//       if (uri != null && uri.queryParameters.containsKey('ref')) {
       

//         setState(() {
//           referralCode = uri.queryParameters['ref'];
//            GetStorage().write('referralCode', referralCode);
           
//           isFromReferral = true;
//         });
    
//       }
//     });

//     // Check deep link if app was opened from closed state
//     Uri? initialUri = await appLinks.getInitialLink();
//     if (initialUri != null && initialUri.queryParameters.containsKey('ref')) {
//       setState(() {
//         referralCode = initialUri.queryParameters['ref'];
//            GetStorage().write('referralCode', referralCode);
//         print(referralCode);
//         isFromReferral = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return UserDashboardScreen(); // If logged in, go to Dashboard
//           } else {
//             if (isFromReferral) {
//               return SignUpScreen(
//                   refferalCode: referralCode); // Go to Signup if from referral
//             } else {
//               return UserLoginScreen(); // Otherwise, go to Login
//             }
//           }
//         },
//       ),
//     );
//   }
// }
