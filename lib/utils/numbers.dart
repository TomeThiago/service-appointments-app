import 'package:intl/intl.dart';

String formatMoney(double value) {
  final formatINTL = NumberFormat("#,##0.00", "pt_BR");

  return formatINTL.format(value);
}