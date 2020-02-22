

class News{

  News({this.title, this.content, this.publisher, this.publishedAt, this.tags});

  String title;
  String content;
  String publisher;
  DateTime publishedAt;
  List<String> tags = [];
}