import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class WithdrawRecordController extends GetxController  {
  

  var pendingPayments = <QueryDocumentSnapshot>[].obs;
  var completedPayments = <QueryDocumentSnapshot>[].obs;
  var cancelledPayments = <QueryDocumentSnapshot>[].obs;
  
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
    
    // 🔥 Filter: Sirf 'Deposit' type transactions fetch karo
    var querySnapshot = await FirebaseFirestore.instance
        .collection('payments')
        .where('transactionType', isEqualTo: 'Withdraw').orderBy('createdAt', descending: true)
        .get();
    
    pendingPayments.clear();
    completedPayments.clear();
    cancelledPayments.clear();
    
    for (var doc in querySnapshot.docs) {
      String status = doc['status'] ?? '';
      
      if (status == 'pending') {
        pendingPayments.add(doc);
      } else if (status == 'completed') {
        completedPayments.add(doc);
      } else if (status == 'cancelled') {
        cancelledPayments.add(doc);
      }
    }
  } catch (e) {
    errorMessage.value = 'Failed to fetch payments: ${e.toString()}';
  } finally {
    isLoading(false);
  }
}

 
} 