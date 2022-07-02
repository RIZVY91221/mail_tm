

import 'package:get/get.dart';
import 'package:mail_tm/app/data/model/domain_response_model.dart';
import 'package:mail_tm/app/data/model/login_response.dart';
import 'package:mail_tm/app/data/model/massege_response.dart';
import 'package:mail_tm/app/data/remote/mail_tm_remote_data_source.dart';



import 'mail_tm_repository.dart';

class MailTmRepositoryImpl implements MailTmRepository{
  final MailTmRemoteDataSource _remoteSource =
  Get.find(tag: (MailTmRemoteDataSource).toString());

  @override
  Future<DomainResponse> getDomainRep() {

   return _remoteSource.getDomain();
  }

  @override
  Future createRegistrationRepo(String email, String password) {

    return _remoteSource.createRegistration(email, password);
  }

  @override
  Future<LoginResponse> loginRepo(String email, String password) {

    return _remoteSource.loginMailTm(email, password);
  }

  @override
  Future<MessageResponse> messageResponse() {

    return _remoteSource.getMessageResponse();
  }


}