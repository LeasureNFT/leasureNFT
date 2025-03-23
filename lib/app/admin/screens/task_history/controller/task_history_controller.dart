import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TaskHistoryController extends GetxController {
  RxList<Map<String, dynamic>> completedTasksWithUser = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompletedTasks();
  }

  Future<void> fetchCompletedTasks() async {
    try {
      isLoading.value = true;

      // Fetch completed tasks from Firestore
      QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
          .collection('task_details')
          .where('isComplete', isEqualTo: true)
          .orderBy('createdAt', descending: true) // Sort by most recent
          .get();

      List<Map<String, dynamic>> tempList = [];

      // Fetch user details for each task
      for (var taskDoc in taskSnapshot.docs) {
        String userId = taskDoc['userId'];

        // Fetch user document
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            
            .doc(userId)
            
            .get();

        Map<String, dynamic> taskData = taskDoc.data() as Map<String, dynamic>;

        if (userSnapshot.exists) {
          // Add user details
          taskData.addAll({
            'userName': userSnapshot['username'] ?? 'Unknown User',
            'userEmail': userSnapshot['email'] ?? 'No Email',
          });
        } else {
          // If user not found, add default values
          taskData.addAll({
            'userName': 'Unknown User',
            'userEmail': 'No Email',
          });
        }

        tempList.add(taskData);
      }

      completedTasksWithUser.assignAll(tempList);
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