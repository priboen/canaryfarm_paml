import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/canarydetail_controller.dart';

class CanarydetailView extends GetView<CanarydetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CanarydetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CanarydetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
