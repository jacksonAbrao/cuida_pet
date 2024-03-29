import 'package:cuida_pet/app/core/helpers/constants.dart';
import 'package:cuida_pet/app/core/helpers/environments.dart';
import 'package:cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet/app/core/loggger/app_logger.dart';
import 'package:cuida_pet/app/core/rest_client/dio/interceptos/auth_interceptor.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client_exception.dart';
import 'package:cuida_pet/app/core/rest_client/rest_client_response.dart';
import 'package:cuida_pet/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;

  final _defaulOptions = BaseOptions(
    baseUrl: Environments.param(Constants.ENV_BASE_URL_KEY) ?? '',
    connectTimeout: int.parse(
        Environments.param(Constants.REST_CLIENT_CONNECT_TIMEOUT_KEY) ?? '0'),
    receiveTimeout: int.parse(
        Environments.param(Constants.REST_CLIENT_RECEIVE_TIMEOUT_KEY) ?? '0'),
  );

  DioRestClient({
    required LocalStorage localStorage,
    required AppLogger log,
    required AuthStore authStore,
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(baseOptions ?? _defaulOptions);
    _dio.interceptors.addAll([
      AuthInterceptor(
          localStorage: localStorage, logger: log, authStore: authStore),
      LogInterceptor(requestBody: true, responseBody: true)
    ]);
  }

  @override
  RestClient auth() {
    _defaulOptions.extra[Constants.AUTH_REQUIRED] = true;
    return this;
  }

  @override
  RestClient unauth() {
    _defaulOptions.extra[Constants.AUTH_REQUIRED] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverter<T>(
      Response<dynamic> response) async {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  Never _throwRestClientException(DioError dioError) {
    final response = dioError.response;

    throw RestClientException(
      error: dioError.error,
      message: response?.statusMessage,
      statusCode: response?.statusCode,
      response: RestClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
      ),
    );
  }
}
