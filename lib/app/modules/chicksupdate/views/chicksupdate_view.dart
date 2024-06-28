import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chicksupdate_controller.dart';

class ChicksupdateView extends GetView<ChicksupdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChicksupdateView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChicksupdateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
