import 'package:app/models/category.dart';
import 'package:app/models/logged_user.dart';
import 'package:app/models/worker.dart';
import 'package:app/repositories/booking_repository.dart';
import 'package:app/repositories/category_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _userTable = "users";

  Future<dynamic> insertData(String collectionName, dynamic data) async {
    return _db.collection(_userTable).add(data);
  }

  Future<LoggedUser> getUserByEmail(String email) async {
    QuerySnapshot querySnapshot =
        await _db.collection(_userTable).where("email", isEqualTo: email).get();

    List<QueryDocumentSnapshot> userDocument = querySnapshot.docs;

    LoggedUser user = LoggedUser.toModel(userDocument[0]);

    return user;
  }

  Future<void> updateProfile(String userId, String name, String cpf, String bio) async {
    DocumentReference documentReference = _db.collection(_userTable).doc(userId);

    Map<String, dynamic> dataToUpdate = {
      'name': name,
      'cpf': cpf,
      'bio': bio
    };

    await documentReference.update(dataToUpdate);
  }

  Future<void> updateAvatar(String userId, String avatarUrl) async {
    DocumentReference documentReference = _db.collection(_userTable).doc(userId);

    Map<String, dynamic> dataToUpdate = {
      'avatarUrl': avatarUrl,
    };

    await documentReference.update(dataToUpdate);
  }

  Future<void> updateCategory(String userId, String categoryId, Map<String, double> servicesSelected) async {
    DocumentReference documentReference = _db.collection(_userTable).doc(userId);

    await documentReference.update({
      'services': FieldValue.delete(),
    });

    List<Map<String, dynamic>> servicesData = [];

    servicesSelected.forEach((id, value) {
      servicesData.add({
        'id': id,
        'value': value,
      });
    });

    Map<String, dynamic> dataToUpdate = {
      'categoryId': categoryId,
      'services': FieldValue.arrayUnion(servicesData),
    };

    await documentReference.update(dataToUpdate);
  }

  Future<void> updateAddress(String userId, Address address) async {
    DocumentReference documentReference = _db.collection(_userTable).doc(userId);

    await documentReference.update({
      'address': FieldValue.delete(),
    });

    Map<String, dynamic> dataToUpdate = {
      'address': {
        'cep': address.cep,
        'city': address.city,
        'complement': address.complement,
        'neighborhood': address.neighborhood,
        'street': address.street,
      },
    };

    await documentReference.update(dataToUpdate);
  }

  Future<List<Worker>> getWorkers(Category category, Service service) async {
    QuerySnapshot querySnapshot = await _db.collection(_userTable)
        .where("typeProfile", isEqualTo: 'worker')
        .where("categoryId", isEqualTo: category.id)
        .get();

    List<QueryDocumentSnapshot> workersDocument = querySnapshot.docs;

    List<Worker> listWorkers = [];

    for (var element in workersDocument) {
      var worker = Worker.toModel(element);

      for (var elementService in worker.serviceAvailable ?? []) {
        if (elementService.id == service.id) {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;
          var category = await CategoryRepository().getCategoryById(data['categoryId'] ?? '');

          worker.categoryTitle = category?.title ?? 'Não Informado';
          worker.totalBookings = await BookingRepository().getTotalBookingsByWorkerId(worker.id);

          listWorkers.add(worker);
        }
      }
    }

    return listWorkers;
  }

  Future<Worker?> getWorkerById(String workerId) async {
    DocumentSnapshot userSnapshot = await _db.collection(_userTable).doc(workerId).get();

    if (userSnapshot.exists) {
      Worker worker = Worker.toModel(userSnapshot);

      return worker;
    }

    return null;
  }
}
