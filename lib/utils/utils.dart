import 'package:intl/intl.dart';

//para poner la primera letra en mayuscula
extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
}

String getData(int timestamp1) {
  if (timestamp1 == 0) {
    return '-';
  } else {
    final DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
    final date1 = DateFormat.yMMMMEEEEd('es').format(date);
    final time = DateFormat('h:mm a').format(date);
    return '$date1 $time'.inCaps;
  }
}

String getHora(int timestamp1) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
  final time = DateFormat('h:mm a').format(date);
  return time.inCaps;
}

String getFecha(int timestamp1) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
  final time = DateFormat('d/MMM/y').format(date);
  return time.inCaps;
}

String getFechaNormal(int timestamp1) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
  final time = DateFormat('y-M-d H:mm:ss').format(date);
  return time.inCaps;
}

//tengo n minutos calcular antidad de dias, horas, minutos
String getTiempo(int minutos) {
  final dias = minutos ~/ 1440;
  final horas = minutos ~/ 60;
  final minutos1 = minutos % 60;
  if (dias > 0) {
    return '$dias dias $horas horas $minutos1 minutos';
  } else if (horas > 0) {
    return '$horas horas $minutos1 minutos';
  } else {
    return '$minutos1 minutos';
  }
}
