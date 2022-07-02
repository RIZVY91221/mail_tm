import 'package:get/get.dart';
import 'package:mail_tm/app/modules/domain/controllers/domain_controller.dart';




class DomainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DomainController>(
      () => DomainController(),
    );
  }
}
