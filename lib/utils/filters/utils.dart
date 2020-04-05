import 'package:flutter/foundation.dart';
import 'package:inked/data/model/filter.dart';

const Map<FilterAction, int> filterActionLevelMap = {
  FilterAction.ALERT: 4,
  FilterAction.NOTIFY: 3,
  FilterAction.HIGHLIGHT: 2,
  FilterAction.HIDE: 1,
  FilterAction.IGNORE: 0,
};

NewsFilterResult getHighestNewsFilterResult(List<NewsFilterResult> filters) {
  try {
    if (filters == null || filters.length == 0) {
      return null;
    }
    NewsFilterResult highest;
    int highestLevel = -1;
    for (var filter in filters) {
      var level = filterActionLevelMap[filter.action];
      if (level == highestLevel) {
        if (highest.score < filter.score){
          highestLevel = level;
          highest = filter;
        }
      } else if (level > highestLevel) {
        highestLevel = level;
        highest = filter;
      }
    }
    print("highest is $highest");
    return highest;
  } catch (e) {
    return null;
  }
}

bool isHigherOrEven({@required FilterAction high, @required FilterAction low}) {
  return filterActionLevelMap[high] >= filterActionLevelMap[low];
}
