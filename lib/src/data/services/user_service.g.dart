// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

/// Implementación mínima generada de [UserService] para Retrofit.
class _UserService implements UserService {
  _UserService(this._dio, {this.baseUrl});

  final Dio _dio;
  String? baseUrl;

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _dio.fetch<List<dynamic>>(RequestOptions(method: 'GET', path: '/users', baseUrl: baseUrl ?? _dio.options.baseUrl));
    return response.data!.map((json) => UserModel.fromJson(Map<String, dynamic>.from(json as Map))).toList(growable: false);
  }

  @override
  Future<UserModel> createUser(CreateUserRequestDto request) async {
    final response = await _dio.fetch<Map<String, dynamic>>(RequestOptions(method: 'POST', path: '/users', baseUrl: baseUrl ?? _dio.options.baseUrl, data: request.toJson()));
    return UserModel.fromJson(response.data!);
  }
}
