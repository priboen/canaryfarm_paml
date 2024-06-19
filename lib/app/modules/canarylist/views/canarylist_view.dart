import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/canarylist_controller.dart';

class CanarylistView extends GetView<CanarylistController> {
  const CanarylistView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CanarylistView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CanarylistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
