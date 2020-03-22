highlight(String content, String target){
  content.replaceAll(target, "<mark>$target</mark>");
}