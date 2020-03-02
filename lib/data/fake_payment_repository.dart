import 'dart:math';

import 'model/payment.dart';
import 'payment_repository.dart';

class FakePaymentRepository implements PaymentRepository {
  double cachedTempAmount;

  @override
  Future<Payment> fetchPayment(String payee) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network error
        if (random.nextBool()) {
          //throw NetworkError();
        }

        // Since we're inside a fake repository, we need to cache the temperature
        // in order to have the same one returned for the detailed weather
        cachedTempAmount = 20 + random.nextInt(15) + random.nextDouble();

        return Payment(
          payee: payee,
          amount: cachedTempAmount,
          status: 'Success',
          month: 'January'
        );
      },
    );
  }

  @override
  Future<Payment> fetchDetailedPayment(String payee) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Payment(
          payee: payee,
          amount: cachedTempAmount,
          status: 'Success',
          month: 'January'
        );
      },
    );
  }
}

class NetworkError extends Error {}