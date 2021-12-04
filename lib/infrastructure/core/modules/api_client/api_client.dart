import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:house_of_auctions/infrastructure/core/constants/di.dart';
import 'package:house_of_auctions/infrastructure/core/modules/token_storage/token_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class ApiClient {
  final Dio _dio = Dio();
  final HiveTokenStorage storage;

  ApiClient({required this.storage}) {
    final tokenModel = storage.read();

    _dio.options.baseUrl = env.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10).inMilliseconds;
    _dio.options.receiveTimeout = const Duration(seconds: 5).inMilliseconds;
    if (tokenModel != null) _dio.options.headers['authorization'] = 'Bearer ${tokenModel.accessToken}';

    if (env.debugApiClient) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } on DioError {
      rethrow;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      return await _dio.put(path, data: data);
    } on DioError {
      rethrow;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioError {
      rethrow;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioError {
      rethrow;
    } catch (e) {
      throw Exception(e);
    }
  }
}
