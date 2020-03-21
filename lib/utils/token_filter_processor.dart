import 'package:inked/data/model/filter.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/utils/tokenizer.dart';

abstract class IFilterProcessor{
  bool process();
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
      filter.extraFilters.forEach((eFilter) {
        if (eFilter.isOn){
          var result = TokenFilterProcessor(news, eFilter).process();
          filterResults.add(result);
        }
      });
    }

    // TODO check by operation
    switch(filter.operation){
      case OperationType.And:
        // TODO: Handle this case.
        // filter results && layer results should all be true
        break;
      case OperationType.Or:
        // TODO: Handle this case.
        // one of filter results && layer results should be true
        break;
    }

  }
}

class SingleTokenFilterLayerProcessor implements IFilterProcessor{
  final News news;
  final SingleTokenFilterLayer layer;
  String content;
  Tokenizer tokenizer;
  SingleTokenFilterLayerProcessor(this.news, this.layer){
    content = getTargetContent();
    tokenizer = Tokenizer(content);
  }

  @override
  bool process() {
    return processMatchLogic();
  }

  bool processMatchLogic(){
    // TODO inspect this logic
    bool matched = false;
    tokenizer.tokens.forEach((token) {
      switch(layer.match){
        case MatchType.Contains:
          matched = token.contains(content);
          break;
        case MatchType.Matches:
          matched = token == content;
          break;
      }
    });
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
}