// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leasure_nft/app/routes/app_pages.dart';
import 'package:leasure_nft/app/routes/app_routes.dart';
import 'package:leasure_nft/app/services/initial_setting_services.dart';
import 'package:leasure_nft/firebase_options.dart';

Future<void> _initServices() async {
  Get.log("Initial Servicess Starting ..... ");
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Get.putAsync(() => InitialSettingServices().init());
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("firebase error = ${e.toString()}");
  }

  Get.log("Initial Servicess Started!");
}

void main() async {
  await _initServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
          //   3
          // 60,690
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.leftToRight,
          title: 'Leasure NFT',
          themeMode: ThemeMode.system,
          getPages: AppPages.pages,
          initialRoute: AppRoutes.initial,
          theme: Get.find<InitialSettingServices>().getLightTheme(),
        ),
      ),
    );
  }
}

// "hosting": {
//     "public": "build/web",
//     "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
//     "rewrites": [
//       {
//         "source": "**",
//         "destination": "/index.html"
//       }
//     ],
//     "errorPages": {
//       "404": "/404.html"
//     }
//   }
