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

    // 🔥 Get current user ID
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // 🔥 Get the timestamp for one month ago
    Timestamp oneMonthAgo = Timestamp.fromDate(
      DateTime.now().subtract(Duration(days: 30)),
    );

    // 🔥 Fetch only last 1 month completed tasks for the current user
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('task_details')
        .where('userId', isEqualTo: userId)
        .where('isComplete', isEqualTo: true)
        .where('createdAt', isGreaterThanOrEqualTo: oneMonthAgo) // ✅ Last 1 month only
        .orderBy('createdAt', descending: true)
        .get();

    // Assign fetched tasks to RxList
    completedTasks.assignAll(querySnapshot.docs);

    // 🔥 Delete tasks older than 1 month
    await deleteOldCompletedTasks(oneMonthAgo, userId);
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

// Function to delete old completed tasks (older than 1 month)
Future<void> deleteOldCompletedTasks(Timestamp oneMonthAgo, String userId) async {
  try {
    QuerySnapshot oldTasksSnapshot = await FirebaseFirestore.instance
        .collection('task_details')
        .where('userId', isEqualTo: userId) // ✅ Only current user's tasks
        .where('isComplete', isEqualTo: true)
        .where('createdAt', isLessThan: oneMonthAgo) // 🔥 Older than 1 month
        .get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (var doc in oldTasksSnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    Get.log("🔥 Old completed tasks deleted successfully for user: $userId.");
  } catch (e) {
    Get.log("❌ Error deleting old completed tasks: $e");
  }
}
}
