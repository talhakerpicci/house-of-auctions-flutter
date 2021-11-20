import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:house_of_auctions/domain/models/core/token_model.dart';
import 'package:house_of_auctions/infrastructure/core/constants/di.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class ApiClient {
  final Dio _dio = Dio();
  final TokenStorage<TokenModel> storage;

  ApiClient({required this.storage}) {
    _dio.options.baseUrl = env.apiBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10).inMilliseconds;
    _dio.options.receiveTimeout = const Duration(seconds: 5).inMilliseconds;
    _dio.interceptors.add(
      Fresh<TokenModel>(
        tokenStorage: storage,
        refreshToken: _refreshAccessToken,
        tokenHeader: (token) {
          return {
            'authorization': 'Bearer ${token.accessToken}',
          };
        },
      ),
    );

    if (env.debugApiClient) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }

  Future<TokenModel> _refreshAccessToken(TokenModel? token, Dio dio) async {
    // TODO: Implement refresh token
    if (token != null) {
      /* final result = await getIt<OpenIdConnectService>().refreshAccessToken(token.refreshToken); */
      var result;

      if (result != null) {
        return TokenModel(
          accessToken: result.accessToken!,
          refreshToken: result.refreshToken!,
        );
      }
    }

    throw RevokeTokenException();
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } catch (e) {
      throw Exception(e);
    }
  }
}
