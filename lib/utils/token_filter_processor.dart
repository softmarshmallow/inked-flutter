import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/utils/tokenizer.dart';

abstract class IFilterProcessor{
  bool process();
  List<bool> results = [];
}


class TokenFilterProcessor implements IFilterProcessor{
  final News news;
  final TokenFilter filter;
  TokenFilterProcessor(this.news, this.filter);

  @override
  bool process(){
    List<bool> layerResults = [];
    filter.filterLayers.forEach((layer) {
      var result = SingleTokenFilterLayerProcessor(news, layer).process();
      layerResults.add(result);
    });

    List<bool> filterResults = [];
    // only run sub filters if it is root filter
    if (filter.isRootFilter){
      if (filter.extraFilters != null) {
        filter.extraFilters.forEach((eFilter) {
          if (eFilter.isOn){
            var result = TokenFilterProcessor(news, eFilter).process();
            filterResults.add(result);
          }
        });
      }
    }

    results..addAll(layerResults)..addAll(filterResults);

    switch(filter.operation){
      case OperationType.And:
      // filter results && layer results should all be true
        for (var i in results){
          if (!i) {
            return false;
          }
        }
        return true;
        break;
      case OperationType.Or:
        // one of filter results && layer results should be true
        for (var i in results){
          if (i) {
            return true;
          }
        }
        return false;
        break;
    }
    return false;
  }

  @override
  List<bool> results = [];
}

class SingleTokenFilterLayerProcessor implements IFilterProcessor{
  final News news;
  final SingleTokenFilterLayer layer;
  String content;
  WordTokenizer tokenizer;
  SingleTokenFilterLayerProcessor(this.news, this.layer){
    content = getTargetContent();
    tokenizer = WordTokenizer(content)..tokenize();
  }

  @override
  bool process() {
    return processMatchLogic();
  }

  bool processMatchLogic(){
    bool matched = false;
    for (var contentToken in tokenizer.tokens){
      // if once matched, return anyway.
      if (matched == true){
        print("matched = $matched // contentToken = $contentToken // layer.token = ${layer.token} // logic = ${layer.match} // content = $content");
        return matched;
      }
      logic: switch(layer.match){
        case FilterMatchType.Contains:
          matched = content.contains(layer.token);
          break logic;
        case FilterMatchType.Matches:
          matched = contentToken == layer.token;
          break logic;
        case FilterMatchType.NotContains:
          matched = !content.contains(layer.token);
          break logic;
        case FilterMatchType.NotMatches:
          matched = contentToken != layer.token;
          break logic;
      }
    }
    return matched;
  }

  String getTargetContent(){
    switch(layer.scope){
      case FilterScope.Title:
        return news.title;
        break;
      case FilterScope.Body:
        return news.content;
        break;
    }
    return null;
  }

  @override
  List<bool> results = [];
}