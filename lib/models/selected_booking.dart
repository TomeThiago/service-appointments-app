import 'package:app/models/category.dart';
import 'package:app/models/worker.dart';

class SelectedBooking {
  Worker worker;
  Category category;
  Service service;
  double value;

  SelectedBooking({
    required this.worker,
    required this.category,
    required this.service,
    required this.value,
  });
}
