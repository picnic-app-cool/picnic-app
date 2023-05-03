import 'package:intl/intl.dart';

String formatNumber(int number) => NumberFormat('#,###,##0').format(number);
