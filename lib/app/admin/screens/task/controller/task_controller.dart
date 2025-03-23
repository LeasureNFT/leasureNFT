import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();
  final isLoading = true.obs;
  RxList<QueryDocumentSnapshot> taskList = <QueryDocumentSnapshot>[].obs;
 @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getTasks();
    });
    super.onInit();
  }
  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    urlController.clear();
  }

  void addTask() async {
    try {
      isLoading.value = true;

      // 🔹 Firestore میں Task Add کریں
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'url': urlController.text.trim(),
        "rating": 0,
        'isCompleted': false, // ❌ Default Task Incomplete
        'createdAt': FieldValue.serverTimestamp(), // 🔥 Time Save
      });

      Fluttertoast.showToast(
        msg: "Task added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      await getTasks();
      Get.back();

      clearControllers();
    } catch (e) {
      Get.snackbar('Error in add task', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTasks() async {
    try {
      isLoading.value = true;
      
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('tasks').orderBy('createdAt', descending: true).get();
      taskList.value = querySnapshot.docs;
    } catch (e) {
      Get.snackbar('Error in get task', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void deleteTask({id}) async {
    try {
      isLoading.value = true;
      await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
      Fluttertoast.showToast(
        msg: "Task deleted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      await getTasks();
    } catch (e) {
      Get.snackbar('Error in delete task', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
