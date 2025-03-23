import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final auth = FirebaseAuth.instance;
  final totalRevenue = 0.0.obs;
  RxList<Map<String, dynamic>> usersList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUsers();
    calculateTotalRevenue(); // ✅ Automatically fetch users on screen load
  }

  void logout() async {
    await auth.signOut();
    Get.offAllNamed('/login');
  }

  // 🔹 Firestore سے تمام Users حاصل کرنے کا Function
  void getUsers() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .listen((snapshot) {
        usersList.value = snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch users: $e");
    }
  }

  Future<void> calculateTotalRevenue() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // 1️⃣ Get total number of users
      QuerySnapshot usersSnapshot = await firestore.collection('users').get();
      int totalUsers = usersSnapshot.size;

      // 2️⃣ Get total tasks assigned to each user
      QuerySnapshot tasksSnapshot = await firestore.collection('tasks').get();
      int tasksPerUser =
          tasksSnapshot.size; // Assuming all users get equal tasks

      // 3️⃣ Calculate total profit from task_details
      QuerySnapshot taskDetailsSnapshot =
          await firestore.collection('task_details').get();

      double totalProfit = 0.0;

      for (var doc in taskDetailsSnapshot.docs) {
        double profit = doc['profit'] ?? 0.0; // Ensure profit exists
        totalProfit += profit;
      }

      // 4️⃣ Calculate Total Revenue Formula
      double totalRevenueAm =
          totalUsers * tasksPerUser * (totalProfit / taskDetailsSnapshot.size);

      print("Total Revenue: $totalRevenueAm");
      totalRevenue.value = totalRevenueAm;
    } catch (e) {
      print("Error calculating total revenue: $e");
    }
  }
}
