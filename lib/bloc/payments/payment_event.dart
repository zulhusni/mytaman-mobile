part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class GetPayment extends PaymentEvent {
  final String payee;

  const GetPayment(this.payee);

  @override
  List<Object> get props => [payee];
}

class GetDetailedPayment extends PaymentEvent {
  final String payee;

  const GetDetailedPayment(this.payee);

  @override
  List<Object> get props => [payee];
}
