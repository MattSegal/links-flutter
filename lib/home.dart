import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'models.dart';
import 'api.dart' as api;

class HomePage extends StatelessWidget {
  build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Links')),
      body: LinksList(),
    );
  }
}

class LinksList extends StatefulWidget {
  createState() => LinkListState();
}

class LinkListState extends State<LinksList> {
  List<Link> _links = [];

  void initState() {
    super.initState();
    api.loadLinks().then((resp) {
      setState(() {
        _links = resp.results;
      });
    });
  }

  build(context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: _links.length,
      itemBuilder: (context, index) => LinkRow(_links[index]),
    );
  }
}

class LinkRow extends StatelessWidget {
  final Link link;
  LinkRow(this.link);
  build(context) {
    var domain = Uri.parse(link.url).host;
    var subtitle =
        '${link.username} - ${timeago.format(link.created)} - $domain';
    if (link.description.isNotEmpty) {
      subtitle += ' - description';
    }
    return Container(
        child: ListTile(
      title: Hyperlink(link.title, link.url),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.more_horiz),
    ));
  }
}

class Hyperlink extends StatelessWidget {
  final String url;
  final String text;
  Hyperlink(this.text, this.url);
  build(context) {
    return GestureDetector(
        child: Text(text,
            style: TextStyle(
                color: Color(0xFF3388CC), fontWeight: FontWeight.bold)),
        onTap: () {
          launch(url);
        });
  }
}
