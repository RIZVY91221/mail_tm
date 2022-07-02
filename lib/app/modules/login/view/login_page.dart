
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mail_tm/app/core/values/app_colors.dart';
import 'package:mail_tm/app/core/values/app_values.dart';
import 'package:mail_tm/app/core/values/text_styles.dart';
import 'package:mail_tm/app/core/widget/loading.dart';
import 'package:mail_tm/app/modules/login/controller/login_controller.dart';


class LoginPage extends StatelessWidget {

  final controller=Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor:Colors.white,
        appBar:PreferredSize(
          preferredSize: const Size.fromHeight(AppValues.margin_50),
          child:  Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: _titleText(context),
              leading: IconButton(
                visualDensity: VisualDensity.standard,
                onPressed: ()=>Get.back(),
                icon:const Icon(Icons.arrow_back,size: AppValues.margin_30,color: AppColors.colorPrimary,) ,
              ),
            ),
          ),
        ),
        body:SafeArea(
            child: Obx(()=>controller.isLoading.value?const Center(child:Loading(),):Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: AppValues.margin_20,right: AppValues.margin_20,top: AppValues.margin_50),
                  height: context.height,
                  width: context.width,
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.loginFormKey,
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(height: 40,),
                          _headerText(),
                          const SizedBox(height: 30,),
                          _buildEmailTF(),
                          const SizedBox(height: 20,),
                          _buildPasswordTF(),
                          const SizedBox(height: 50,),
                          loginButton(context),

                        ],
                      ),
                    ),
                  ),
                ),
              ],

            )
            )
        )
    );
  }
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),

        _emailTextField()

      ],
    );
  }
  Widget _emailTextField(){
    return Container(
      alignment: Alignment.centerLeft,
      //decoration: kBoxDecorationStyle,

      //height: AppValues.margin_50,
      child: TextFormField(
        controller: controller.emailController,
        validator:(value){
          return controller.validateEmail(value!);
        },
        onSaved: (value){
          controller.email=value!;
        },
        //controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          color: AppColors.colorDark,
          fontFamily: 'Poppins',

        ),
        decoration: InputDecoration(
          //border: InputBorder.none,
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(
                  color: AppColors.colorDark.withOpacity(AppValues.oppTextField),
                  width: 2
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(
                color: AppColors.colorDark.withOpacity(AppValues.oppTextField),
                width: 2.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            hintText: 'Enter your Email',
            hintStyle: const TextStyle(color: AppColors.colorDark),

        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 7.0),
        _passwordTextField()
      ],
    );
  }
  Widget _passwordTextField(){
    return  Container(
        alignment: Alignment.centerLeft,
        //decoration: kBoxDecorationStyle,
        //height: AppValues.margin_50,
        child: Obx(()=>TextFormField(
          obscureText:controller.passwordVisible.value ,
          onSaved: (value)=>controller.password=value!,
          validator: (value){
            return controller.validatePassword(value!);
          },
          //controller:passwordController,
          style: const TextStyle(
            color: AppColors.colorDark,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  controller.passwordVisible.isFalse
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color:AppColors.colorPrimary,
                ),
                onPressed: ()=>controller.visiblePass()
            ),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(
                  color: AppColors.colorDark.withOpacity(AppValues.oppTextField),
                  width: 2
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(
                color: AppColors.colorDark.withOpacity(AppValues.oppTextField),
                width: 2.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
            prefixIcon: const Icon(
              Icons.vpn_key_sharp,
              color: Colors.black,
            ),
            hintText: 'Enter your Password',
            hintStyle: const TextStyle(color:AppColors.colorDark),
          ),
        ),)
    );
  }

  Widget loginButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: Material(  //Wrap with Material
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(7.0) ),
        elevation: 0.0,
        color:AppColors.colorPrimary,
        clipBehavior: Clip.antiAlias, // Add This
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width/4,
          height: AppValues.margin_50,
          color: AppColors.colorPrimary,
          child:const Text('Sign In',
              style: TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: ()=>controller.checkLogin(),
        ),
      ),
    );
  }

  Widget _headerText(){
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: AppValues.defaultAnimation),
      duration: const Duration(seconds: 3),
      builder: (BuildContext context, double size, Widget? child) {
        return Container(
            alignment: Alignment.center,
            height: AppValues.margin_50,
            width: size,
            padding: const EdgeInsets.all(10),
            child: child);
      },
      child: RichText(
        text: const TextSpan(
          text: 'Mail',
          style: TextStyle(
              letterSpacing: 3, color: Colors.amber, fontSize: 30),
          children: <TextSpan>[
            TextSpan(
              text: '.',
            ),
            TextSpan(
                text: 'TM',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    fontSize: 30)),
          ],
        ),
      ),
    );
  }
  Widget _titleText(BuildContext context){
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: MediaQuery.of(context).size.width),
      duration: const Duration(seconds: 3),
      builder: (BuildContext context, double size, Widget? child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0,right: 8),
          child: Container(
              alignment: Alignment.center,
              height: AppValues.margin_50,
              width: size,
              padding: const EdgeInsets.all(10),
              child: child),
        );
      },
      child: const Text("Sign In Account",style: titleStyle,),
    );
  }
}