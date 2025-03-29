import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class UserTaskController extends GetxController {
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getTasks();
    });
    super.onInit();
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();
  final isLoading = true.obs;
  final errorMsg = ''.obs;
  RxList<QueryDocumentSnapshot> taskList = <QueryDocumentSnapshot>[].obs;
  var rating = 2.0.obs;
  late YoutubePlayerController youtubeController;
  RxBool isVideoEnded = false.obs;
  RxString videoDuration = "00:00".obs;

  void initializePlayer(String videoUrl) {
    String? videoId = YoutubePlayerController.convertUrlToId(videoUrl);
    if (videoId == null) {
      throw Exception("Invalid YouTube URL: $videoUrl");
    }

    youtubeController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        mute: false,
        loop: false,
        strictRelatedVideos: true,
        showVideoAnnotations: false,
        showControls: false,
        showFullscreenButton: false,
        enableCaption: false,
      ),
    )..listen((event) {
        if (event.playerState == PlayerState.ended) {
          isVideoEnded.value = true;
        }

        final totalDuration = event.metaData.duration.inSeconds;
        videoDuration.value = formatDuration(totalDuration);
      });

    // 🔄 **Real-time duration update every second**
    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (isVideoEnded.value) {
        timer.cancel(); // 🛑 Stop when video ends
      } else {
        double currentTime = await youtubeController.currentTime;
        final totalDuration =
            youtubeController.value.metaData.duration.inSeconds;

        final remainingSeconds = (totalDuration - currentTime).toInt();
        videoDuration.value = formatDuration(remainingSeconds);
      }
    });
  }

// 🎯 **Function to Format Time (mm:ss)**
  String formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int sec = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  void updateRating(double newRating) {
    rating.value = newRating;
  }

  Future<void> getTasks() async {
    try {
      isLoading.value = true;

      // Get current user ID
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception("User is not logged in.");
      }

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (!userDoc.exists) {
        errorMsg.value = "User document not found.";
        throw Exception("User document not found.");
      }

      // Get cashVault value (default to 0 if null)
      double cashVault = double.parse(userDoc['cashVault'].toString());

      // Check if cashVault is below 500
      if (cashVault < 500) {
        errorMsg.value =
            "Your balance is too low. Please deposit at least 500 to access tasks.";

        throw Exception(
            "Your balance is too low. Please deposit at least 500 to access tasks.");
      }

      // Fetch tasks if cashVault is 500 or more
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .orderBy('createdAt', descending: true)
          .get();
      taskList.value = querySnapshot.docs;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitTask({
    required String url,
    required double rating,
    required String taskName,
    required String taskDesc,
  }) async {
    try {
      isLoading.value = true;

      // Step 1: Get current user ID
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        isLoading.value = false;
        throw Exception("User is not logged in.");
      }
      String userId = user.uid;

      // Step 2: Reference Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userRef = firestore.collection('users').doc(userId);

      // Step 3: Fetch user document
      DocumentSnapshot userDoc;
      try {
        userDoc = await userRef.get();
        if (!userDoc.exists) {
          isLoading.value = false;
          throw Exception("User document does not exist.");
        }
      } catch (e) {
        isLoading.value = false;
        throw Exception("Failed to retrieve user data: $e");
      }

      // Step 4: Fetch current cashVault & referral profit (default to 0 if null)
      double cashValue =
          double.tryParse(userDoc['cashVault'].toString()) ?? 0.0;
      double refferrelProfit =
          double.tryParse(userDoc['refferralProfit'].toString()) ?? 0.0;

      // Step 5: Calculate profit ONLY if referral profit is greater than 0
      double profit = 0.0;
      if (refferrelProfit >= 0) {
        profit = cashValue * 0.02; // 2% of cashVault
        cashValue += cashValue * 0.02;
        refferrelProfit += profit;

        // Step 6: Update cashVault & referral profit in Firestore
        try {
          await userRef.update({
            'cashVault': cashValue, // Corrected: Using actual double
            //  total profit hai
            'refferralProfit':
                refferrelProfit // Keeping as double // total profit
          });
        } catch (e) {
          isLoading.value = false;
          throw Exception("Failed to update user's cashVault: $e");
        }
      }

      // Step 7: Save task details in Firestore
      CollectionReference tasks = firestore.collection('task_details');
      try {
        await tasks.add({
          'userId': userId,
          'url': url,
          'profit': profit, // Calculated profit
          'rating': rating,
          'taskName': taskName,
          'taskDesc': taskDesc,
          'isComplete': true, // Task marked as completed
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'videoCompletedAt': FieldValue.serverTimestamp(),
        }).then((value) async {
          Fluttertoast.showToast(msg: "Task submitted successfully!");
          await getTasks();
          Get.back();
        });
      } catch (e) {
        isLoading.value = false;
        Fluttertoast.showToast(msg: "Failed to save task details: $e");
        throw Exception("Failed to save task details: $e");
      }

      print("✅ Task submitted successfully! Profit: Rs $profit added.");
    } catch (e) {
      isLoading.value = false;
      print("❌ Error in submitTask: $e");
    }
  }
}
