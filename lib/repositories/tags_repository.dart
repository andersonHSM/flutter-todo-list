import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo/app/models/tag.dart';
import 'package:todo/utils/app_urls.dart';

class TagsRepository {
  static const tagsUrl = "${AppUrls.baseUrl}/tags";
  static Dio dio = Dio();

  Future<Tag> saveTag(Tag tag) async {
    final response = await dio.post<Map<String, dynamic>>("$tagsUrl.json",
        data: tag.toJson());

    Tag returnedTag = tag;
    returnedTag.id = response.data['name'];

    return returnedTag;
  }

  Future<List<Tag>> fetchTags() async {
    final response = await dio.get<Map<String, dynamic>>("$tagsUrl.json");

    List<Tag> tags = [];
    response.data.forEach((key, value) {
      Tag tag = Tag.fromJson(value);
      tag.id = key;

      tags.add(tag);
    });

    return tags;
  }

  Future<void> updateTag(Tag tag) async {
    await dio.put("$tagsUrl/${tag.id}.json", data: json.encode(tag.toJson()));
  }

  Future<void> deleteTag(Tag tag) async {
    await dio.delete<Map<String, dynamic>>("$tagsUrl/${tag.id}.json");
  }
}
