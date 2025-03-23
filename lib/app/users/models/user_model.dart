import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? userId;
  final String? username;
  final String? email;
  final String? image;
  final String? password;
  final double? cashVault;
  final double? depositAmount;
  final double? reward;
  final double? withdrawAmount;
  final double? refferralProfit;
  final String? refferredBy;
  final Timestamp? createdAt;

  UserModel({
    this.userId,
    this.username,
    this.email,
    this.image,
    this.password,
    this.cashVault,
    this.depositAmount,
    this.reward,
    this.withdrawAmount,
    this.refferralProfit,
    this.refferredBy,
    this.createdAt,
  });

  // Factory method to create UserModel from Firestore document
  factory UserModel.fromMap(Map<String, dynamic>? data) {
    if (data == null) return UserModel(); // اگر ڈیٹا null ہو تو خالی ماڈل ریٹرن کرے

    return UserModel(
      userId: data['userId'],
      username: data['username'],
      email: data['email'],
      image: data['image'],
      password: data['password'],
      cashVault: double.tryParse(data['cashVault'].toString()) ?? 0.0,
      depositAmount: double.tryParse(data['depositAmount'].toString()) ?? 0.0,
      reward: double.tryParse(data['reward'].toString()) ?? 0.0,
      withdrawAmount: double.tryParse(data['withdrawAmount'].toString()) ?? 0.0,
      refferralProfit: double.tryParse(data['refferralProfit'].toString()) ?? 0.0,
      refferredBy: data['refferredBy'],
      createdAt: data['createdAt'],
    );
  }

  // Convert UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'image': image,
      'password': password,
      'cashVault': cashVault ?? 0.0,
      'depositAmount': depositAmount?.toString() ?? "0",
      'reward': reward?.toString() ?? "0",
      'withdrawAmount': withdrawAmount?.toString() ?? "0",
      'refferralProfit': refferralProfit?.toString() ?? "0",
      'refferredBy': refferredBy,
      'createdAt': createdAt,
    };
  }
}
