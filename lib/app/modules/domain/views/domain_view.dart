import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mail_tm/app/core/values/app_values.dart';
import 'package:mail_tm/app/core/values/text_styles.dart';
import 'package:mail_tm/app/core/widget/paging_view.dart';
import 'package:mail_tm/app/data/local/preference/preference_manager.dart';
import 'package:mail_tm/app/modules/domain/controllers/domain_controller.dart';
import 'package:mail_tm/app/routes/app_page.dart';

import '/app/core/base/base_view.dart';
import '/app/core/widget/custom_app_bar.dart';


class DomainPage extends BaseView<DomainController> {
  DomainPage() {
    controller.getDomainList();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: 'Domain',
    );
  }

  @override
  Widget body(BuildContext context) {
    return PagingView(
      onRefresh: () async {
        controller.onRefreshPage();
      },
      onLoadNextPage: () {
        controller.onLoadNextPage();
      },
      child: Padding(
        padding: const EdgeInsets.all(AppValues.padding),
        child: Obx(
              () => ListView.separated(
            shrinkWrap: true,
            itemCount: controller.domainList.length,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var model = controller.domainList[index];

              return ListTile(
                onTap: () async{
                  final PreferenceManager _preferenceManager = Get.find(tag: (PreferenceManager).toString());
                  var token =await _preferenceManager.getString(PreferenceManager.keyToken);
                  if(token == null || token == ""){
                    Get.toNamed(AppRoutes.REGISTER, arguments: {
                      PreferenceManager.domainKey: controller.domainList[index].domain!
                    });
                  } else {
                    Get.toNamed(AppRoutes.CHECK_MESSAGE);
                  }
                },
                title: Text(model.domain!,style: cardTitleStyle,),
                subtitle: Text(model.type!,style: cardSubtitleStyle,),
                leading: CircleAvatar(child: Text((index + 1).toString())),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: AppValues.smallMargin),
          ),
        ),
      ),
    );
  }
}
