part of comps;

class Hyperlink extends StatelessWidget {
  final String url;
  final String text;
  Hyperlink(this.text, this.url);
  build(context) {
    return GestureDetector(
        child: Text(text, style: style), onTap: () => launch(url));
  }
}

const style = TextStyle(
    fontSize: 16, color: Color(0xFF3388CC), fontWeight: FontWeight.bold);
