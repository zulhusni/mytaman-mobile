import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytaman_mobile/pages/payment_search_page.dart';

import 'bloc/payments/payment_bloc.dart';
import 'data/fake_payment_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      home: BlocProvider(
        builder: (context) => PaymentBloc(FakePaymentRepository()),
        child: PaymentSearchPage(),
      ),
    );
  }
}
