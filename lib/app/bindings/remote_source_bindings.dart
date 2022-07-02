import 'package:get/get.dart';
import 'package:mail_tm/app/data/remote/mail_tm_remote_data_source.dart';
import 'package:mail_tm/app/data/remote/main_tm_remote_data_source_impl.dart';


class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MailTmRemoteDataSource>(
      () => MailTmRemoteDataSourceImpl(),
      tag: (MailTmRemoteDataSource).toString(),
    );
  }
}
