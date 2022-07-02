import 'package:get/get.dart';
import 'package:mail_tm/app/core/base/base_controller.dart';
import 'package:mail_tm/app/core/base/paging_controller.dart';
import 'package:mail_tm/app/data/model/massege_response.dart';
import 'package:mail_tm/app/data/repository/mail_tm_repository.dart';
import 'package:mail_tm/app/modules/masseage/model/message_ui_model.dart';


class MassageController extends BaseController{
  final MailTmRepository _repository =
  Get.find(tag: (MailTmRepository).toString());

  final RxList<MessageUiModel> _messageListController =
  RxList.empty();

  List<MessageUiModel> get messageList =>
      _messageListController.toList();

  final pagingController = PagingController<MessageUiModel>();

  void getMessageList() {
    if (!pagingController.canLoadNextPage()) return;

    pagingController.isLoadingPage = true;


    var messageListService = _repository.messageResponse();

    callDataService(
      messageListService,
      onSuccess: _handleProjectListResponseSuccess,
    );

    pagingController.isLoadingPage = false;
  }

  void _handleProjectListResponseSuccess(MessageResponse response) {
    List<MessageUiModel>? messageList = response.hydraMember
        ?.map((e) => MessageUiModel(
     subject: e.subject ?? "Null",
      intro: e.intro ?? "Null",
      createdAt: e.createdAt ?? "Null",
      address: e.from!.address ?? "Null"
    ))
        .toList();

    _messageListController(messageList);
  }
}