// A logged in user
class User {
  final int id;
  final String username;

  User(this.id, this.username);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
      };
}

// A link to a webpage, shared by a user.
class Link {
  final int id;
  final DateTime created;
  final String description;
  final String title;
  final String url;
  final String username;

  Link(this.id, this.created, this.description, this.title, this.url,
      this.username);

  Link.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        created = DateTime.parse(json['created']),
        description = json['description'],
        title = json['title'],
        url = json['url'],
        username = json['username'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'created': created,
        'description': description,
        'title': title,
        'url': url,
        'username': username,
      };
}
