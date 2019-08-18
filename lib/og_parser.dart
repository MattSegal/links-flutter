// https://github.com/Patte1808/open_graph_parser
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';
import 'dart:async';
import 'dart:convert';

Future<Map<dynamic, dynamic>> getOpenGraphData(String url) async {
  var response = await http.get(url);

  return getOpenGraphDataFromResponse(response);
}

Map<String, dynamic> getOpenGraphDataFromResponse(http.Response response) {
  var requiredAttributes = ['title', 'image'];
  Map<String, dynamic> data = new Map<String, dynamic>();

  if (response.statusCode == 200) {
    var document = parser.parse(utf8.decode(response.bodyBytes));
    var openGraphMetaTags = _getOpenGraphData(document);

    openGraphMetaTags.forEach((element) {
      var ogTagTitle = element.attributes['property'].split("og:")[1];
      var ogTagValue = element.attributes['content'];

      if ((ogTagValue != null && ogTagValue != "") ||
          requiredAttributes.contains(ogTagTitle)) {
        if (ogTagValue == null || ogTagValue.length == 0) {
          ogTagValue = _scrapeAlternateToEmptyValue(ogTagTitle, document);
        }
        data[ogTagTitle] = ogTagValue;
      }
    });
  }

  return data;
}

String _scrapeAlternateToEmptyValue(String tagTitle, Document document) {
  if (tagTitle == "title") {
    return document.head.getElementsByTagName("title")[0].text;
  }

  if (tagTitle == "image") {
    var images = document.body.getElementsByTagName("img");

    if (images.length > 0) {
      return images[0].attributes["src"];
    }

    return "";
  }

  return "";
}

List<Element> _getOpenGraphData(Document document) {
  return document.head.querySelectorAll("[property*='og:']");
}
