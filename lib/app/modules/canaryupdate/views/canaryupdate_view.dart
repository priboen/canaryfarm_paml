import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/canaryupdate_controller.dart';

class CanaryupdateView extends GetView<CanaryupdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CanaryupdateView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CanaryupdateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
