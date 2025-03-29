import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDepositRecordController extends GetxController  {
 var pendingPayments = <Map<String, dynamic>>[].obs;
  var completedPayments = <Map<String, dynamic>>[].obs;
  var cancelledPayments = <Map<String, dynamic>>[].obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var currentTab = 0.obs;
  void changeTab(int index) {
    currentTab.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchPayments(); // Fetch payments when controller initializes
  }

  Future<void> fetchPayments() async {
    try {
      isLoading(true);
      errorMessage.value = '';

      Timestamp oneMonthAgo = Timestamp.fromDate(
        DateTime.now().subtract(Duration(days: 30)),
      );
      String userId = FirebaseAuth.instance.currentUser!.uid;
      var querySnapshot = await FirebaseFirestore.instance
          .collection('payments')
          .where('transactionType', isEqualTo: 'Deposit') // ✅ Only "Withdraw"
          .where('userId', isEqualTo: userId)
          .where('createdAt',
              isGreaterThanOrEqualTo: oneMonthAgo) // ✅ Last 1 month only
          .orderBy('createdAt', descending: true)
          .get();

      // ✅ Temporary lists
      List<Map<String, dynamic>> pendingList = [];
      List<Map<String, dynamic>> completedList = [];
      List<Map<String, dynamic>> cancelledList = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> paymentData =
            Map<String, dynamic>.from(doc.data()); // ✅ Correct Type Conversion
        paymentData['id'] = doc.id; // Add document ID

        String userId = paymentData['userId'] ?? '';

        // 🔥 Fetch user details
        var userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        if (userDoc.exists) {
          paymentData['username'] = userDoc.data()?['username'] ?? 'Unknown';
          paymentData['email'] = userDoc.data()?['email'] ?? 'Unknown';
        } else {
          paymentData['username'] = 'Unknown';
          paymentData['email'] = 'Unknown';
        }

        // 🔥 Categorize payments
        if (paymentData['status'] == 'pending') {
          pendingList.add(paymentData);
        } else if (paymentData['status'] == 'completed') {
          completedList.add(paymentData);
        } else if (paymentData['status'] == 'cancelled') {
          cancelledList.add(paymentData);
        }
      }

      // ✅ Correct way to update RxList
      pendingPayments.value = pendingList;
      completedPayments.value = completedList;
      cancelledPayments.value = cancelledList;

      await deleteOldDeposits(oneMonthAgo, userId);
    } catch (e) {
      errorMessage.value = 'Failed to fetch payments: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }
// Function to delete old Deposit transactions (older than 1 month) for current user
Future<void> deleteOldDeposits(Timestamp oneMonthAgo, String userId) async {
  try {
    QuerySnapshot oldPaymentsSnapshot = await FirebaseFirestore.instance
        .collection('payments')
        .where('transactionType', isEqualTo: 'Deposit')
        .where('userId', isEqualTo: userId) // ✅ Only current user's transactions
        .where('createdAt', isLessThan: oneMonthAgo) // 🔥 Older than 1 month
        .get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (var doc in oldPaymentsSnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    Get.log("🔥 Old Deposit transactions deleted successfully for user: $userId.");
  } catch (e) {
    Get.log("❌ Error deleting old Deposit transactions: $e");
  }
}

  
} 