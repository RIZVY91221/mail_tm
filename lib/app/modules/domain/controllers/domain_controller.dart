import 'package:get/get.dart';
import 'package:mail_tm/app/core/base/paging_controller.dart';
import 'package:mail_tm/app/data/model/domain_response_model.dart';
import 'package:mail_tm/app/data/repository/mail_tm_repository.dart';
import 'package:mail_tm/app/modules/domain/model/domain_ui_data.dart';


import '/app/core/base/base_controller.dart';

class DomainController extends BaseController {
  final MailTmRepository _repository =
  Get.find(tag: (MailTmRepository).toString());

  final RxList<DomainListUiData> _domainListController =
  RxList.empty();

  List<DomainListUiData> get domainList =>
      _domainListController.toList();

  final pagingController = PagingController<DomainListUiData>();

  void getDomainList() {
    if (!pagingController.canLoadNextPage()) return;

    pagingController.isLoadingPage = true;


    var domainListService = _repository.getDomainRep();

    callDataService(
      domainListService,
      onSuccess: _handleProjectListResponseSuccess,
    );

    pagingController.isLoadingPage = false;
  }

  onRefreshPage() {
    pagingController.initRefresh();
    getDomainList();
  }

  onLoadNextPage() {
    logger.i("On load next");

    getDomainList();
  }

  void _handleProjectListResponseSuccess(DomainResponse response) {
    List<DomainListUiData>? repoList = response.hydraMember
        ?.map((e) => DomainListUiData(
      type: e.type ?? "Null",
      id: e.id ?? "Null",
      domain: e.domain ?? "Null",
    ))
        .toList();

    if (_isLastPage(repoList!.length, response.hydraMember!.length)) {
      pagingController.appendLastPage(repoList);
    } else {
      pagingController.appendPage(repoList);
    }

    var newList = [...pagingController.listItems];

    _domainListController(newList);
  }

  bool _isLastPage(int newListItemCount, int totalCount) {
    return (domainList.length + newListItemCount) >= totalCount;
  }
}
