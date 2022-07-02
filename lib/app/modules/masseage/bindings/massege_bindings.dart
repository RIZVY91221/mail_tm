import 'package:get/get.dart';
import 'package:mail_tm/app/modules/masseage/controller/massege_controller.dart';


class MassageBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MassageController>(
          () => MassageController(),
    );
  }

}