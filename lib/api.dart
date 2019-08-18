import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

const BASE_URL = 'https://mattslinks.xyz/api';

Future<LinkListResponse> loadLinks({String next}) async {
  final url = next.isNotEmpty ? next : '$BASE_URL/link/';
  final resp = await http.get(url);
  if (resp.statusCode != 200) {
    throw Exception('Failed to fetch links.');
  }
  final jsonString = utf8.decode(resp.body.codeUnits);
  return LinkListResponse.fromJson(jsonDecode(jsonString));
}

class LinkListResponse {
  final int count;
  final String next;
  final String previous;
  final List<Link> results;

  LinkListResponse.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        next = json['next'],
        previous = json['previous'],
        results = parseResults(json['results']);

  static List<Link> parseResults(List<dynamic> results) {
    return results.map((data) => Link.fromJson(data)).toList();
  }
}
