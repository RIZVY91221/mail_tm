 import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSimpleSnackBar(msg){
  Get.rawSnackbar(
    backgroundColor: Colors.red,
    message: msg,
    snackPosition: SnackPosition.BOTTOM,
  );
}
 showSuccessSnackBar(msg){
   Get.rawSnackbar(
     backgroundColor: Colors.green,
     message: msg,
     snackPosition: SnackPosition.BOTTOM,
   );
 }