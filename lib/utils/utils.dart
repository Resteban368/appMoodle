import 'package:intl/intl.dart';

//para poner la primera letra en mayuscula
extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
}

String getData(int timestamp1) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
  final date1 = DateFormat.yMMMMEEEEd('es').format(date);
  final time = DateFormat('h:mm a').format(date);
  return '$date1 $time'.inCaps;
}
