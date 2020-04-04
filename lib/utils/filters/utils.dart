import 'package:flutter/foundation.dart';
import 'package:inked/data/model/filter.dart';

const Map<FilterAction, int> filterActionScoreMap = {
  FilterAction.ALERT: 4,
  FilterAction.NOTIFY: 3,
  FilterAction.HIGHLIGHT: 2,
  FilterAction.HIDE: 1,
  FilterAction.IGNORE: 0,
};

NewsFilterResult getHighestNewsFilterResult(List<NewsFilterResult> filters) {
  try {
    NewsFilterResult highest;
    int highestScore = -1;
    for (var filter in filters) {
      var score = filterActionScoreMap[filter.action];
      if (score > highestScore) {
        highestScore = score;
        highest = filter;
      }
    }
    return highest;
  } catch (e) {
    return null;
  }
}

bool isHigherOrEven({@required FilterAction high, @required FilterAction low}) {
  return filterActionScoreMap[high] >= filterActionScoreMap[low];
}
