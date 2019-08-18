part of comps;

class LinkRow extends StatelessWidget {
  final Link link;
  LinkRow(this.link);

  build(context) {
    var subtitle = getSubtitle(link);
    return Container(
      child: ListTile(
          title: Hyperlink(link.title, link.url),
          subtitle: Text(subtitle),
          trailing: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () => _onToggleOpen(context))),
    );
  }

  _onToggleOpen(BuildContext context) {
    final route =
        MaterialPageRoute(builder: (context) => LinkDetailsModal(link));
    Navigator.of(context).push(route);
  }
}

class LinkDetailsModal extends StatelessWidget {
  final Link link;
  LinkDetailsModal(this.link);
  build(context) {
    var subtitle = getSubtitle(link);
    return Scaffold(
        appBar: AppBar(title: Text('Link Details')),
        body: Container(
            padding: EdgeInsets.all(32),
            child: Row(children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: const Color(0x55000000),
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(1, 1),
                          )
                        ],
                      ),
                      child: LinkImage(link.url)),
                  Container(
                      padding: EdgeInsets.only(bottom: 4, top: 16),
                      child: Hyperlink(link.title, link.url)),
                  Container(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(subtitle,
                          style: TextStyle(color: Color(0x8A000000)))),
                  Text(link.description),
                ],
              ))
            ])));
  }
}

class LinkImage extends StatefulWidget {
  final String url;
  LinkImage(this.url);
  createState() => LinkImageState();
}

class LinkImageState extends State<LinkImage> {
  Future<String> _image;

  void initState() {
    super.initState();
    _image = getOpenGraphData(widget.url).then((ogData) => ogData['image']);
  }

  build(context) {
    return FutureBuilder(
      future: _image,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data;
          return FadeInImage.assetNetwork(
            placeholder: 'assets/img/empty-image.png',
            image: image,
            width: 400,
            height: 200,
            fit: BoxFit.cover,
          );
        }
        return Image.asset(
          'assets/img/empty-image.png',
          width: 400,
          height: 200,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

getSubtitle(Link link) {
  var parts = Uri.parse(link.url).host.split('.');
  var domain = parts.sublist(parts.length - 2, parts.length).join('.');
  var subtitle = '${link.username} - ${timeago.format(link.created)} - $domain';
  if (link.description.isNotEmpty) {
    subtitle += ' - description';
  }
  return subtitle;
}
