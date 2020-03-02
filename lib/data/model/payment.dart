import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Payment extends Equatable {
  final String payee;
  final String month;
  final String status;
  final double amount;

  Payment({
    @required this.payee,
    @required this.month,
    @required this.status,
    @required this.amount,
  });

  @override
  List<Object> get props => [
        payee,
        month,
        status,
        amount,
      ];
}