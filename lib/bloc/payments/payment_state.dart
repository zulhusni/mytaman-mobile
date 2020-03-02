part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
  @override
  List<Object> get props => [];
}

class PaymentLoaded extends PaymentState {
  final Payment payment;
  const PaymentLoaded(this.payment);
  @override
  List<Object> get props => [payment];
}

class PaymentError extends PaymentState {
  final String message;
  const PaymentError(this.message);
  @override
  List<Object> get props => [message];
}
