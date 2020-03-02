import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytaman_mobile/bloc/payments/payment_bloc.dart';
import 'package:mytaman_mobile/data/model/payment.dart';

class PaymentDetailPage extends StatefulWidget {
  final Payment masterPayment;

  const PaymentDetailPage({
    Key key,
    @required this.masterPayment,
  }) : super(key: key);

  @override
  _PaymentDetailPageState createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<PaymentBloc>(context)
      ..add(GetDetailedPayment(widget.masterPayment.payee));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return buildLoading();
            } else if (state is PaymentLoaded) {
              return buildColumnWithData(context, state.payment);
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Payment payment) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          payment.payee,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the Celsius temperature with 1 decimal place
          "RM ${payment.amount.toStringAsFixed(1)} || ${payment.month} || ${payment.status}",
          style: TextStyle(fontSize: 80),
        )
      ],
    );
  }
}