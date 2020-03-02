import 'model/payment.dart';

abstract class PaymentRepository {
  Future<Payment> fetchPayment(String payee);
  Future<Payment> fetchDetailedPayment(String payee);
}