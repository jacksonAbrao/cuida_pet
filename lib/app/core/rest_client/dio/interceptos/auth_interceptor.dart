import 'package:cuida_pet/app/core/helpers/constants.dart';
import 'package:dio/dio.dart';

import 'package:cuida_pet/app/core/local_storage/local_storage.dart';
import 'package:cuida_pet/app/core/loggger/app_logger.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final AppLogger _logger;

  AuthInterceptor({
    required LocalStorage localStorage,
    required AppLogger logger,
  })  : _localStorage = localStorage,
        _logger = logger;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired = options.extra[Constants.AUTH_REQUIRED] ?? false;

    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);

      if (accessToken == null) {
        return handler.reject(
          DioError(
            requestOptions: options,
            error: 'Expire Token',
            type: DioErrorType.cancel,
          ),
        );
      }

      options.headers['Authorization'] = accessToken;
    } else {
      options.headers.remove('Authorization');
    }
    handler.next(options);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   super.onResponse(response, handler);
  // }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   super.onError(err, handler);
  // }
}
