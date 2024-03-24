import 'package:app/models/category.dart';
import 'package:app/models/user_register.dart';
import 'package:app/models/worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? id;
  String userId;
  User? user;
  String workerId;
  Worker? worker;
  String categoryId;
  Category? category;
  String serviceId;
  Service? service;
  String data;
  String address;
  String typePayment;
  double value;
  String status;

  Booking({
    this.id,
    required this.userId,
    required this.workerId,
    required this.categoryId,
    required this.serviceId,
    required this.data,
    required this.typePayment,
    required this.value,
    required this.status,
    required this.address,
    this.worker,
    this.category,
    this.service,
    this.user,
  });

  factory Booking.toModel(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Booking(
      id: snapshot.id,
      userId: data["userId"],
      workerId: data["workerId"],
      categoryId: data["categoryId"],
      serviceId: data["serviceId"],
      data: data["data"],
      address: data["address"],
      typePayment: data["typePayment"],
      value: data["value"],
      status: data["status"],
    );
  }

  static Map<String, dynamic> toEntity(Booking booking) {
    final bookingEntity = <String, dynamic>{
      'userId': booking.userId,
      'workerId': booking.workerId,
      'categoryId': booking.categoryId,
      'serviceId': booking.serviceId,
      'data': booking.data,
      'typePayment': booking.typePayment,
      'value': booking.value,
      'address': booking.address,
      'status': booking.status,
    };

    return bookingEntity;
  }
}
