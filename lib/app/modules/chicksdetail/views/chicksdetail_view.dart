import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chicksdetail_controller.dart';

class ChicksdetailView extends GetView<ChicksdetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChicksdetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChicksdetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
