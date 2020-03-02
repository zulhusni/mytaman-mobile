import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytaman_mobile/bloc/payments/payment_bloc.dart';
import 'package:mytaman_mobile/data/model/payment.dart';
import 'package:mytaman_mobile/pages/payment_detail_page.dart';

class PaymentSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              if (state is PaymentInitial) {
                return buildInitialInput();
              } else if (state is PaymentLoading) {
                return buildLoading();
              } else if (state is PaymentLoaded) {
                return buildColumnWithData(context, state.payment);
              } else if (state is PaymentError) {
                return buildInitialInput();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
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
          // Display the temperature with 1 decimal place
          "RM ${payment.amount.toStringAsFixed(1)}",
          style: TextStyle(fontSize: 80),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<PaymentBloc>(context),
                  child: PaymentDetailPage(
                    masterPayment: payment,
                  ),
                ),
              ),
            );
          },
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitPaymentPayee(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitPaymentPayee(BuildContext context, String payee) {
    BlocProvider.of<PaymentBloc>(context).add(GetPayment(payee));
  }
}