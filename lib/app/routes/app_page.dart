import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mail_tm/app/modules/domain/bindings/domain_binding.dart';
import 'package:mail_tm/app/modules/domain/views/domain_view.dart';
import 'package:mail_tm/app/modules/login/bindings/login_bindings.dart';
import 'package:mail_tm/app/modules/login/view/login_page.dart';
import 'package:mail_tm/app/modules/masseage/bindings/massege_bindings.dart';
import 'package:mail_tm/app/modules/masseage/view/massege_view.dart';
import 'package:mail_tm/app/modules/register/binding/register_bindings.dart';
import 'package:mail_tm/app/modules/register/view/registration_page.dart';



class AppRoutes {
  static const String HOME = '/'; // domain list
  static const String CHECK_MESSAGE = '/check-message';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';

  static var pageList = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => DomainPage(),
      binding: DomainBindings()
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegistrationPage(),
      binding: RegisterBindings()
    ),

    GetPage(
      name: AppRoutes.CHECK_MESSAGE,
      page: () => MessageView(),
      binding: MassageBindings()
    ),
  ];
}