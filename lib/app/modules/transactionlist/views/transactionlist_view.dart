import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transactionlist_controller.dart';

class TransactionlistView extends GetView<TransactionlistController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransactionlistView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TransactionlistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
