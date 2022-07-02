import 'package:flutter/material.dart';
import 'package:mail_tm/app/core/base/base_widget_mixin.dart';
import 'package:mail_tm/app/modules/masseage/model/message_ui_model.dart';

class MessageItem extends StatelessWidget with BaseWidgetMixin {
  final MessageUiModel dataModel;

  MessageItem({
    Key? key,
    required this.dataModel,
  }) : super(key: key);

  @override
  Widget body(BuildContext context) {
    return ExpansionTile(
      title: Text(
        dataModel.subject!,
      ),
      leading: const Icon(Icons.mail_outline),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(
            'from ${dataModel.address}',
            style: const TextStyle(
                fontSize: 13, color: Colors.white70),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(dataModel.createdAt!,
              style: const TextStyle(
                  fontSize: 12, color: Colors.white38)),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(dataModel.intro!,
              style: const TextStyle(fontSize: 15)),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}