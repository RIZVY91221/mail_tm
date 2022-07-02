

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mail_tm/app/core/utils/snakber_util.dart';
import 'package:mail_tm/app/data/local/preference/preference_manager.dart';
import 'package:mail_tm/app/data/repository/mail_tm_repository.dart';


class LoginController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final MailTmRepository _repository = Get.find(tag: (MailTmRepository).toString());
  final PreferenceManager _preferenceManager = Get.find(tag: (PreferenceManager).toString());
  RxBool isLoading=false.obs;
  final passwordVisible=true.obs;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var email='';
  var password='';

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }

    return null;
  }
  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }

    return null;
  }
  visiblePass(){
    if(passwordVisible.isFalse){
      return passwordVisible.value=true;
    }else if(passwordVisible.isTrue){
      return passwordVisible.value=false;
    }
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    isLoading.value=true;
    loginFormKey.currentState!.save();
    _repository.loginRepo(email, password).then((value){
      if(value.token==null || value.token==""){
        showSimpleSnackBar("Please try again...");
        isLoading(false);
      }else{
        _preferenceManager.setString(PreferenceManager.keyToken, value.token!);
        isLoading(false);
        Get.back();
        Get.back();
        showSuccessSnackBar("SignIn Successfully");
      }
    });

  }
}