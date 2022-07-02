
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mail_tm/app/core/utils/snakber_util.dart';
import 'package:mail_tm/app/core/values/app_values.dart';
import 'package:mail_tm/app/data/local/preference/preference_manager.dart';
import 'package:mail_tm/app/data/model/registration_response.dart';
import 'package:mail_tm/app/data/model/registration_vaiolation_response.dart';
import 'package:mail_tm/app/data/repository/mail_tm_repository.dart';
import 'package:mail_tm/app/routes/app_page.dart';


class RegisterController extends GetxController{
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final MailTmRepository _repository =
  Get.find(tag: (MailTmRepository).toString());
  RxBool isLoading=false.obs;
  final passwordVisible=true.obs;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final regResponse=RegistrationResponse().obs;
  final regErrorResponse=RegistrationErrorResponse().obs;
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

  void checkRegistration() {
    final isValid = signUpFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    signUpFormKey.currentState!.save();
    isLoading(true);
    String address=email+"@"+Get.arguments[PreferenceManager.domainKey];
    debugPrint("data:${address.toString()}");
    _repository.createRegistrationRepo(address, password).then((value) {
      debugPrint("data:${value.toString()}");
      if(value.toString().trim()==AppValues.UNPROCESSED){
        showSimpleSnackBar(AppValues.UNPROCESSED);
        isLoading(false);
      }else if(value.toString().trim()==AppValues.INVALID){
        showSimpleSnackBar(AppValues.INVALID);
        isLoading(false);
      } else{
        emailController.clear();
        passwordController.clear();
        isLoading(false);
        Get.back();
        Get.toNamed(AppRoutes.LOGIN);
      }
    });

  }
}