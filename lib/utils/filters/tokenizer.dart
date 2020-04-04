class WordTokenizer{
  WordTokenizer(this.content);
  final String content;
  List<String> tokens = [];
  List<String> tokenize(){
    tokens = content.split(" ");
    return tokens;
  }
}