import 'package:flutter/material.dart';
import 'package:livingtechassignment/screens/dashboard/model/news_model.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:livingtechassignment/screens/dashboard/repository/dashboard_repository.dart';
import 'package:livingtechassignment/utils/utils.dart';

class DashboardProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  PagingController<int, NewsModel> newsPagingController =
      PagingController<int, NewsModel>(firstPageKey: 1);

  initFetchNews() {
    newsPagingController.addPageRequestListener((pageKey) {
      getNewsData(
        pageKey,
      );
    });
  }

  Future getNewsData(int page) async {
    final apiResponse =
        await DashboardRepository.instance.getNewsData(page: page);
    apiResponse.fold(
      (l) {
        Utils.showSnackBar(l.error ?? 'Something went wrong');
      },
      (r) {
        final isLastPage = r.length < 20;

        if (!isLastPage) {
          newsPagingController.appendPage(r, page + 1);
        } else {
          newsPagingController.appendLastPage(r);
        }
      },
    );
  }
}
