

import 'package:mail_tm/app/data/model/domain_response_model.dart';
import 'package:mail_tm/app/data/model/login_response.dart';
import 'package:mail_tm/app/data/model/massege_response.dart';

abstract class MailTmRemoteDataSource{
  Future<DomainResponse> getDomain();
  Future createRegistration(String email,String password);
  Future<LoginResponse> loginMailTm(String email,String password);
  Future<MessageResponse> getMessageResponse();
}