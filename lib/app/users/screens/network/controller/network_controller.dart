import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var referralTree =
      <Map<String, dynamic>>[].obs; // Store referrals as list of maps
  String? userId;
  final isloading = false.obs;
  late TreeController treeController;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      treeController = TreeController(allNodesExpanded: false);
      isloading.value = true;
      userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await fetchReferrals(userId!);
      }
      isloading.value = false;
    });
    super.onInit();
  }

  Future<List<Map<String, dynamic>>> getReferralNodes(String userId) async {
    isloading.value = true;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('refferredBy', isEqualTo: userId)
        .get();

    List<Map<String, dynamic>> nodes = [];

    for (var doc in snapshot.docs) {
      List<Map<String, dynamic>> childNodes =
          await getReferralNodes(doc.id); // Recursion for nested referrals
      nodes.add({
        "id": doc.id,
        "name": doc["username"] ?? "Unknown",
        "children": childNodes,
      });
    }

    return nodes;
  }

  Future<void> fetchReferrals(String userId) async {
    try {
      List<Map<String, dynamic>> nodes = await getReferralNodes(userId);
      referralTree.value = nodes;
    } catch (e) {
      print("❌ Error fetching referrals: $e");
    }
  }
}
