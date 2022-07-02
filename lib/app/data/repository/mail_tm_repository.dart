

import 'package:mail_tm/app/data/model/domain_response_model.dart';
import 'package:mail_tm/app/data/model/login_response.dart';
import 'package:mail_tm/app/data/model/massege_response.dart';

abstract class MailTmRepository{
  Future<DomainResponse> getDomainRep();
  Future createRegistrationRepo(String email,String password);
  Future<LoginResponse> loginRepo(String email,String password);
  Future<MessageResponse> messageResponse();
}