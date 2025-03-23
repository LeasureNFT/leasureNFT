import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/users/models/user_model.dart';

class ProfileController extends GetxController {
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  @override
  void onInit() {
    super.onInit();
    listenToUserData(); // ✅ Start real-time listening on init
  }

  void listenToUserData() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      print("❌ No user logged in");
      return;
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen(
      (userDoc) {
        if (userDoc.exists && userDoc.data() != null) {
          userModel.value = UserModel.fromMap(userDoc.data());
          print("✅ Real-time User Data Updated: ${userModel.value?.username}");
        } else {
          print("⚠ User document does not exist");
        }
      },
      onError: (error) {
        print("❌ Error listening to user data: $error");
      },
    );
  }
}
