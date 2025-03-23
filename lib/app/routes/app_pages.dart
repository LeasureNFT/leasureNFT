import 'package:get/get.dart';
import 'package:leasure_nft/app/admin/screens/add_payment_method_screen.dart';
import 'package:leasure_nft/app/admin/screens/admin_main_screen.dart';

import 'package:leasure_nft/app/admin/screens/payment_methods.dart';
import 'package:leasure_nft/app/auth_screens/forget_pasword_screen.dart';
import 'package:leasure_nft/app/auth_screens/sign_up_screen.dart';
import 'package:leasure_nft/app/root/view/root_screen.dart';
import 'package:leasure_nft/app/auth_screens/user_login_screen.dart';
import 'package:leasure_nft/app/routes/app_routes.dart';
import 'package:leasure_nft/app/users/screens/dashboard/main_screen.dart';
import 'package:leasure_nft/app/users/screens/dashboard/user_dashboard_screen.dart';

class AppPages extends AppRoutes {
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => RootScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => UserLoginScreen(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => ForgetPaswordScreen(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => UserMainScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentMethod,
      page: () => PaymentMethodsScreen(),
    ),
    GetPage(
      name: AppRoutes.addPaymentMethod,
      page: () => AddPaymentMethodScreen(),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => AdminMainScreen(),
    ),

// Users

    GetPage(
      name: AppRoutes.userDashboard,
      page: () => UserDashboardScreen(),
    ),

    //     GetPage(
    //     name: AppRoutes.invitationVarification,
    //     page: () => InvitationVarificationScreen(),
    //    ),
    //      GetPage(
    //     name: AppRoutes.profile,
    //     page: () => ProfileScreen(),
    //    ),
    //     GetPage(
    //     name: AppRoutes.subscriptions,
    //     page: () => SubscriptionScreen(),
    //    ),
    // GetPage(
    //     name: AppRoutes.compainesDetails,
    //     page: () => CompainesDetailsScreen(),
    //     middlewares: [
    //       RouteGuard()
    //     ],
    //     children: [
    //       GetPage(
    //           name: AppRoutes.team,
    //           page: () => TeamScreen(),
    //          ),
    //     ]),
  ];
}
