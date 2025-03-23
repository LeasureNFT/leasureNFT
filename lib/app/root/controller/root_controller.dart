
import 'package:get/get.dart';

class RootController extends GetxController {
@override
  void onInit() {
    // WidgetsBinding.instance.addPostFrameCallback((_)async {
    //  final getAdmin = await AppPrefernces.getAdmin;
    //  if(getAdmin != null){
    //   isAdmin.value = true;
    //  }else{
    //   isAdmin.value = false;
    //  }
    // });
   
    super.onInit();
  }
  
  final isAdmin = false.obs;
}
