import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chicks_controller.dart';

class ChicksView extends GetView<ChicksController> {
  const ChicksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChicksView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChicksView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
