import 'package:app/models/booking.dart';
import 'package:app/repositories/category_repository.dart';
import 'package:app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _bookingTable = "booking";

  Future<dynamic> insertData(Booking booking) async {
    var bookingEntity = Booking.toEntity(booking);

    return _db.collection(_bookingTable).add(bookingEntity);
  }

  Future<void> updateStatus(String bookingId, String status) async {
    DocumentReference documentReference = _db.collection(_bookingTable).doc(bookingId);

    Map<String, dynamic> dataToUpdate = {
      'status': status,
    };

    await documentReference.update(dataToUpdate);
  }

  Future<List<Booking>> getBookings(String status) async {
    String statusQuery = 'Pendente';

    if(status == 'Completos') {
      statusQuery = 'Finalizado';
    } else if (status == 'Cancelados') {
      statusQuery = 'Cancelado';
    }

    QuerySnapshot querySnapshot = await _db.collection(_bookingTable)
        .where("status", isEqualTo: statusQuery)
        .get();

    List<QueryDocumentSnapshot> bookingsDocument = querySnapshot.docs;

    List<Booking> listBooking = [];

    for (var document in bookingsDocument) {
      Booking booking = Booking.toModel(document);

      booking.category = await CategoryRepository().getCategoryById(booking.categoryId);
      booking.worker = await UserRepository().getWorkerById(booking.workerId);

      listBooking.add(booking);
    }

    return listBooking;
  }

  Future<int> getTotalBookingsByWorkerId(String workerId) async {
    QuerySnapshot querySnapshot = await _db.collection(_bookingTable)
        .where("workerId", isEqualTo: workerId)
        .get();

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    return documents.length;
  }

  Future<int> getTotalBookingsByUserId(String userId) async {
    QuerySnapshot querySnapshot = await _db.collection(_bookingTable)
        .where("userId", isEqualTo: userId)
        .get();

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    return documents.length;
  }
}
