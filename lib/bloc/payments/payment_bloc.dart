import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mytaman_mobile/data/fake_payment_repository.dart';
import 'package:mytaman_mobile/data/model/payment.dart';
import 'package:mytaman_mobile/data/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository repository;

  PaymentBloc(this.repository);

  @override
  PaymentState get initialState => PaymentInitial();

  @override
  Stream<PaymentState> mapEventToState(
    PaymentEvent event,
  ) async* {
    // Emitting a state from the asynchronous generator
    yield PaymentLoading();
    // Branching the executed logic by checking the event type
    if (event is GetPayment) {
      // Emit either Loaded or Error
      try {
        final payment = await repository.fetchPayment(event.payee);
        yield PaymentLoaded(payment);
      } on NetworkError {
        yield PaymentError("Couldn't fetch Payment. Is the device online?");
      }
    } else if (event is GetDetailedPayment) {
      // Code duplication 😢 to keep the code simple for the tutorial...
      try {
        final payment = await repository.fetchDetailedPayment(event.payee);
        yield PaymentLoaded(payment);
      } on NetworkError {
        yield PaymentError("Couldn't fetch Payment. Is the device online?");
      }
    }
  }
}
