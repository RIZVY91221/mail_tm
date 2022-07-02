import 'package:get/get.dart';
import 'package:mail_tm/app/data/repository/mail_tm_repository.dart';
import 'package:mail_tm/app/data/repository/mail_tm_repository_impl.dart';


class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MailTmRepository>(
      () => MailTmRepositoryImpl(),
      tag: (MailTmRepository).toString(),
    );
  }
}
