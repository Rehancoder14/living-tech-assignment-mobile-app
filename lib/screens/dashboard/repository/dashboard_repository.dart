import 'package:dartz/dartz.dart';
import 'package:livingtechassignment/constants/api_constant.dart';
import 'package:livingtechassignment/helper/apibasehelper.dart';
import 'package:livingtechassignment/screens/dashboard/model/news_model.dart';
import 'package:livingtechassignment/services/api_service.dart';

class DashboardRepository {
  final ApiService _apiService = ApiService();

  static final instance = DashboardRepository._();
  DashboardRepository._();

  Future<Either<ApiError, List<NewsModel>>> getNewsData(
      {required int page}) async {
    return ApiCallWithErrorHandler.call(
      () async {
        final response = await _apiService.get(
          '${ApiConstant.newsApi}&page=$page',
          customBaseURL: true,
        );
        return NewsModel.helper.fromMapArray(response.data['articles']);
      },
    );
  }
}
