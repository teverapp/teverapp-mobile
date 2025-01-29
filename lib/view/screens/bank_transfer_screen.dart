import 'package:flutter/material.dart';
import 'package:tever/view/widgets/bank_transfer_screen/loading_state.dart';
import 'package:tever/view/widgets/bank_transfer_screen/transaction_failed.dart';
import 'package:tever/view/widgets/bank_transfer_screen/transaction_successful.dart';

class BankTransferScreen extends StatelessWidget {
  //This is suppose to be passed through props here
  //To be implemented ones api is ready
  //Taking you to a Paypal
  const BankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(child: TransactionSuccessful()
              //TransactionFailed()
              //

              //LoadingState(),
              )),
    );
  }
}
