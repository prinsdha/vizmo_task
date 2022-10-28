
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:task/core/network/api_client.dart';
import 'package:task/core/network/dio/dio_extension.dart';
import 'package:task/core/network/utils/api_constant.dart';
import 'package:task/ui/employee_detail/model/checkin_detail_model.dart';
import 'package:task/ui/home/model/employee_model.dart';
import 'package:task/ui/home/widget/sort_bottomsheet.dart';
import '../../../ui/home/controller/home_controller.dart';
import 'api_config.dart';
import 'end_point.dart';

class DioApiClient extends ApiClient {
  static late DioApiClient _service;

  static Dio? _dio;

  static Dio get _dioClient => _dio!;

  DioApiClient._();

  static Future<DioApiClient> getInstance() async {
    if (_dio == null) {
      _dio = _init();
      _service = DioApiClient._();
    }
    return _service;
  }

  static Dio _init() {
    final dio = Dio();
    dio.options.baseUrl = UrlPath.baseUrl;
    dio.options.connectTimeout = TimeOut.connectTimeout.inMilliseconds;
    dio.options.receiveTimeout = TimeOut.connectTimeout.inMilliseconds;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (kDebugMode) {
            if (options.data is FormData) {
              FormData d = options.data;
              d.fields.forEach(((field) =>
                  debugPrint('Fields: ${field.key}: ${field.value}')));
              d.files.forEach(((field) => debugPrint(
                  'Files: ${field.key}: ${field.value.filename} (${field.value.contentType?.mimeType})')));
            }
          }
          return handler.next(options);
        },
      ),
    );
    //add logging interceptor with debug check
    dio.interceptors.add(
      LogInterceptor(
        request: kDebugMode,
        error: kDebugMode,
        responseHeader: kDebugMode,
        requestBody: kDebugMode,
        requestHeader: kDebugMode,
        responseBody: kDebugMode,
      ),
    );

    return dio;
  }

  @override
  Future<List<EmployeeModel>> getAllEmployeeList(
      int page, ApiFilter apiFilter) async {
    dynamic param = {
      "page": page,
      "limit": Pagination.maxEmployeeData,
      "sortBy": apiFilter.filterBy!.name,
      "order": apiFilter.sortBy == SortBy.ascending ? "asc" : "desc"
    };

    final response =
        await _dioClient.getApi(UrlPath.employee, queryParameters: param);
    return List<EmployeeModel>.from(
        response.data.map((e) => EmployeeModel.fromJson(e)));
  }

  @override
  Future<List<CheckingDetailModel>> getAllChecking(String id) async {
    final response = await _dioClient.getApi("${UrlPath.employee}/$id/checkin");
    return List<CheckingDetailModel>.from(
        response.data.map((e) => CheckingDetailModel.fromJson(e)));
  }

  @override
  Future<List<EmployeeModel>> getSearchedEmployeeList(
      int page, String? name, String? countryName) async {
    Map<String, dynamic> param = {
      "page": page,
      "limit": Pagination.maxEmployeeData
    };
    if (name != null) {
      param = {...param, "name": name};
    }
    if (countryName != null) {
      param = {...param, "country": countryName};
    }

    final response =
        await _dioClient.getApi(UrlPath.employee, queryParameters: param);

    return List<EmployeeModel>.from(
        response.data.map((e) => EmployeeModel.fromJson(e)));
  }
}
