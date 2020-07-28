import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/app/models/tag.dart';
import 'package:todo/utils/app_urls.dart';

class TagsRepository {
  static Dio dio = Dio();

  final String token;
  final String userId;

  TagsRepository({@required this.userId, @required this.token});

  Future<Tag> saveTag(Tag tag) async {
    final response = await dio.post<Map<String, dynamic>>(
        "${AppUrls.baseUrl}/$userId/tags.json?auth=$token",
        data: tag.toJson());

    Tag returnedTag = tag;
    returnedTag.id = response.data['name'];

    return returnedTag;
  }

  Future<List<Tag>> fetchTags() async {
    final response = await dio.get<Map<String, dynamic>>(
        "${AppUrls.baseUrl}/$userId/tags.json?auth=$token");

    List<Tag> tags = [];

    if (response.data != null) {
      response.data.forEach((key, value) {
        Tag tag = Tag.fromJson(value);
        tag.id = key;

        tags.add(tag);
      });
    }

    return tags;
  }

  Future<void> updateTag(Tag tag) async {
    await dio.put("${AppUrls.baseUrl}/$userId/tags/${tag.id}.json",
        data: json.encode(tag.toJson()));
  }

  Future<void> deleteTag(Tag tag) async {
    await dio.delete<Map<String, dynamic>>(
        "${AppUrls.baseUrl}/$userId/tags/${tag.id}.json");
  }
}
