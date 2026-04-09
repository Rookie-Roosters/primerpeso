import 'package:fixnum/fixnum.dart';
import 'package:intl/intl.dart';

/// Whole pesos (integer units) in es_MX, e.g. $1,234
final NumberFormat _mxn0 = NumberFormat.currency(
  locale: 'es_MX',
  symbol: r'$',
  decimalDigits: 0,
);

String formatMxMoney(int units) => _mxn0.format(units);

String formatSignedMxMoney(int units) {
  if (units < 0) {
    return '-${_mxn0.format(units.abs())}';
  }
  return _mxn0.format(units);
}

/// Formats [Int64] money units (e.g. protobuf [Money.units]).
String formatMxMoneyInt64(Int64 units) => formatMxMoney(units.toInt());
