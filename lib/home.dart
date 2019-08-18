import 'package:flutter/material.dart';

import 'comps/comps.dart';
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
  Future _future;
  List<Link> _links = [];
  String _next = '';

  void initState() {
    super.initState();
    fetchLinks();
  }

  void fetchLinks() {
    _future = api.loadLinks(next: _next).then((resp) {
      setState(() {
        _next = resp.next;
        _links = [..._links, ...resp.results];
      });
    });
  }

  build(context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _links.length + 1,
              itemBuilder: (context, index) {
                if (index < _links.length) {
                  final link = _links[index];
                  return LinkRow(link);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return LoadingSpinner();
                } else if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.done) {
                  fetchLinks();
                  return LoadingSpinner();
                }
                return null;
              });
        });
  }
}
