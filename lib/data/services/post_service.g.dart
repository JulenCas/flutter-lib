// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_service.dart';

/// Implementación mínima generada de [PostService] para Retrofit.
class _PostService implements PostService {
  _PostService(this._dio, {this.baseUrl});

  final Dio _dio;
  String? baseUrl;

  @override
  Future<List<PostModel>> getPosts(int? userId) async {
    final response = await _dio.fetch<List<dynamic>>(
      RequestOptions(method: 'GET', path: '/posts', baseUrl: baseUrl ?? _dio.options.baseUrl, queryParameters: <String, dynamic>{if (userId != null) 'userId': userId}),
    );
    return response.data!.map((json) => PostModel.fromJson(Map<String, dynamic>.from(json as Map))).toList(growable: false);
  }

  @override
  Future<PostModel> createPost(CreatePostRequestDto request) async {
    final response = await _dio.fetch<Map<String, dynamic>>(RequestOptions(method: 'POST', path: '/posts', baseUrl: baseUrl ?? _dio.options.baseUrl, data: request.toJson()));
    return PostModel.fromJson(response.data!);
  }
}
