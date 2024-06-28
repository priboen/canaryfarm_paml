import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chickslist_controller.dart';

class ChickslistView extends GetView<ChickslistController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChickslistView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChickslistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
