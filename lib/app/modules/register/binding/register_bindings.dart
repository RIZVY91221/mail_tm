import 'package:get/get.dart';
import 'package:mail_tm/app/modules/register/controller/register_controller.dart';


class RegisterBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
          () => RegisterController(),
    );
  }

}