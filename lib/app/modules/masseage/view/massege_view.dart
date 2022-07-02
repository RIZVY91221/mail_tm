
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mail_tm/app/core/base/base_view.dart';
import 'package:mail_tm/app/core/values/app_values.dart';
import 'package:mail_tm/app/core/widget/custom_app_bar.dart';
import 'package:mail_tm/app/data/local/preference/preference_manager.dart';
import 'package:mail_tm/app/modules/masseage/controller/massege_controller.dart';
import 'package:mail_tm/app/modules/masseage/widget/message_item.dart';


class MessageView extends BaseView<MassageController>{
  MessageView() {
    controller.getMessageList();
  }
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: 'Inbox',
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: ()=>showDialog(),
        )
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.padding),
      child: Obx(
        () => Column(
          children: [
            Expanded(
              flex: 1,
              child: RefreshIndicator(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.messageList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var model = controller.messageList[index];

                    return MessageItem(dataModel: model);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: AppValues.smallMargin),
                ),
                onRefresh: () async {
                  controller.getMessageList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialog() {
    Get.defaultDialog(
        title: 'Logout',
        titlePadding: const EdgeInsets.all(10),
        titleStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        content: const Text(
          'Do you want sign out?',
          style: TextStyle(
              fontWeight: FontWeight.w300, color: Colors.black, fontSize: 15),
        ),
        confirm: TextButton(
            onPressed: ()async {
              final PreferenceManager _preferenceManager = Get.find(tag: (PreferenceManager).toString());
              await _preferenceManager.remove(PreferenceManager.keyToken);
              Get.back();
              Get.back();
            },
            child: const Text(
              'Confirm',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.green),
            )),
        cancel: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: Colors.red),
            )));
  }
}