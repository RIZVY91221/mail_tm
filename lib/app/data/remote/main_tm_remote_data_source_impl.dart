
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:get/get.dart' as getx;
import 'package:mail_tm/app/core/base/base_remote_source.dart';
import 'package:mail_tm/app/core/utils/snakber_util.dart';
import 'package:mail_tm/app/core/values/app_values.dart';
import 'package:mail_tm/app/data/local/preference/preference_manager.dart';
import 'package:mail_tm/app/data/model/domain_response_model.dart';
import 'package:mail_tm/app/data/model/login_response.dart';
import 'package:mail_tm/app/data/model/massege_response.dart';
import 'package:mail_tm/app/data/model/registration_response.dart';
import 'package:mail_tm/app/data/remote/mail_tm_remote_data_source.dart';
import 'package:mail_tm/app/network/dio_provider.dart';

class MailTmRemoteDataSourceImpl extends BaseRemoteSource implements MailTmRemoteDataSource{

  @override
  Future<DomainResponse> getDomain() {
    var endpoint = "${DioProvider.baseUrl}/domains";
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseMailTmDomainResponse(response));
    } catch (e) {
      rethrow;
    }
  }



  @override
  Future createRegistration(String email, String password) async{
    String _body = json.encode({
      'address': email,
      'password': password,
    });
    var endpoint = "${DioProvider.baseUrl}/accounts";
    final dioCall = dioClient.post(endpoint,data: _body);
    try {
      return callApiWithCodeParse(dioCall)
          .then((response) {
            if(response.statusCode==AppValues.STATUS_CODE ||response.statusCode==AppValues.STATUS_CODE2 ){
              showSuccessSnackBar("Account Created Successfully");

              return _parseMailTmRegistrationResponse(response);
            }else if(response.statusCode==AppValues.STATUS_CODE400){
              return AppValues.INVALID;
            }

            return AppValues.UNPROCESSED;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginResponse> loginMailTm(String email, String password) {
    String _body = jsonEncode(<String, String>{
      'address': email,
      'password': password,
    });
    var endpoint = "${DioProvider.baseUrl}/token";
    var dioCall = dioClient.post(endpoint,data: _body);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessageResponse> getMessageResponse() async {
    final PreferenceManager _preferenceManager = getx.Get.find(tag: (PreferenceManager).toString());
    final String accessToken =
    await _preferenceManager.getString(PreferenceManager.keyToken);
    Map<String,String>head={
      'content-type': 'application/json',
      'Authorization': "Bearer $accessToken",
    };
    var endpoint = "${DioProvider.baseUrl}/messages";
    var dioCall = dioClient.get(endpoint,options: Options(headers: head));

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseMessageResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  DomainResponse _parseMailTmDomainResponse(
      Response<dynamic> response) {
    return DomainResponse.fromJson(response.data);
  }
  RegistrationResponse _parseMailTmRegistrationResponse(
      Response<dynamic> response) {
    return RegistrationResponse.fromJson(response.data);
  }
 /* RegistrationErrorResponse _parseMailTmRegistrationResponseError(
      Response<dynamic> response) {
    return RegistrationErrorResponse.fromJson(response.data);
  }*/
  LoginResponse _parseLoginResponse(
      Response<dynamic> response) {
    return LoginResponse.fromJson(response.data);
  }

  MessageResponse _parseMessageResponse(
      Response<dynamic> response) {
    return MessageResponse.fromJson(response.data);
  }


}