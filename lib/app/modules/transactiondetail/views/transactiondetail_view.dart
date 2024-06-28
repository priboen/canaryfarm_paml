import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transactiondetail_controller.dart';

class TransactiondetailView extends GetView<TransactiondetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransactiondetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TransactiondetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
