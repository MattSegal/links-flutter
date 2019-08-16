import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

const BASE_URL = 'https://mattslinks.xyz/api';

Future<LinkListResponse> loadLinks() async {
  final resp = await http.get('$BASE_URL/link/');
  if (resp.statusCode != 200) {
    throw Exception('Failed to fetch links.');
  }
  return LinkListResponse.fromJson(jsonDecode(resp.body));
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
