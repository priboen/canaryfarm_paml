import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transactionupdate_controller.dart';

class TransactionupdateView extends GetView<TransactionupdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransactionupdateView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TransactionupdateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
