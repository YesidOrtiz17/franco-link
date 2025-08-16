import 'package:intl/intl.dart';

final currencyFormatter = NumberFormat.simpleCurrency(locale: 'es_CO');
final dateFormatter = DateFormat('dd/MM/yyyy');

String formatMoney(num value) => currencyFormatter.format(value);
String formatDate(DateTime d) => dateFormatter.format(d);
