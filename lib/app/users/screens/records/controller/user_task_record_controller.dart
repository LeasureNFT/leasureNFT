import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserTaskRecordController extends GetxController {
  RxList<QueryDocumentSnapshot> completedTasks = <QueryDocumentSnapshot>[].obs;
  RxBool isLoading = false.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchCompletedTasks();
  }

  Future<void> fetchCompletedTasks() async {
    try {
      isLoading.value = true;

      // Get current user ID
      final userId = FirebaseAuth.instance.currentUser!.uid;
      // Fetch completed tasks
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('task_details')
    .where('userId', isEqualTo: userId).orderBy('createdAt', descending: true)
    .where('isComplete', isEqualTo: true)
    .get();

      // Assign fetched tasks to RxList
      completedTasks.assignAll(querySnapshot.docs);
     
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error fetching completed tasks: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      Get.log("Error fetching completed tasks: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
