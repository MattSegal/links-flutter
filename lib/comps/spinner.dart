part of comps;

class LoadingSpinner extends StatelessWidget {
  build(context) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(8),
            width: 40.0,
            height: 40.0,
            child: CircularProgressIndicator()));
  }
}
