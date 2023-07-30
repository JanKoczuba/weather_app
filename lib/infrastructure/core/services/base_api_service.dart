import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/core/utils/safe_print.dart';

import 'package:weather_app/domain/core/failure.dart';

typedef RequestFunction<T> = Future<Either<Failure, T>> Function();

abstract class BaseApiService {
  BaseApiService();

  Future<Either<Failure, T>> makeRequest<T>(RequestFunction<T> function) async {
    try {
      return await function();
    } catch (e) {
      return left(handleError(e));
    }
  }

  Failure handleError(Object e) {
    safePrint('Exception (${e.runtimeType}): $e');

    if (e is DioException) {
      safePrint("Path: ${e.response?.requestOptions.path ?? 'Unknown'}");
      return _handleDioError(e);
    }

    return const Failure.unknown();
  }

  Failure _handleDioError(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      final response = e.response;

      if (response == null) {
        return const Failure.serverConnectionFailure();
      }

      safePrint('DioErrorResponse: $response');

      final statusCode = response.statusCode;

      if (statusCode == 404) {
        return const Failure.notFound();
      }

      if (statusCode != null && statusCode >= 400 && statusCode <= 499) {
        return const Failure.badRequest();
      }

      if (statusCode != null && statusCode >= 500 && statusCode <= 599) {
        return const Failure.serverError();
      }

      if (statusCode != 400) {
        return const Failure.invalidResponse();
      }

      safePrint('Data: ${response.data}');
    }

    return const Failure.unknown();
  }
}
