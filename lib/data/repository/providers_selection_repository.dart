import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inked/data/model/provider_setting.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/user_api.dart';
import 'package:inked/data/repository/base.dart';

const EXCLUDED_PROVIDERS_KEY = "EXCLUDED_PROVIDERS_KEY";

Future<List<String>> loadProvidersList(BuildContext context) async {
  List<String> providers = [];
  String data =
      await DefaultAssetBundle.of(context).loadString("assets/providers.json");
  final jsonResult = json.decode(data);
  for (var r in jsonResult){
    providers.add(r as String);
  }
  return providers;
}

class ProvidersSelectionRepository extends BaseRepository<ProviderSetting>{
  // region singleton
  static final ProvidersSelectionRepository _singleton = ProvidersSelectionRepository._internal();
  factory ProvidersSelectionRepository() {
    return _singleton;
  }
  ProvidersSelectionRepository._internal();
  // endregion

  UserApi api;
  BuildContext _context;
  setContext(BuildContext context){
    _context = context;
  }

  Future<List<ProviderSetting>> loadProvidersSettings (BuildContext context) async {
    List<ProviderSetting> settings = [];
    print("start - loadProvidersSettings");
    var allProviders = await loadProvidersList(context);
    api = UserApi(RemoteApiManager().getDio());
    var remoteProviderSettings = await api.getProviderSettings();
    print("loadProvidersSettings");
    print(remoteProviderSettings);
    settings.addAll(remoteProviderSettings);
    for (var p in allProviders){
      var localSetting = new ProviderSetting(provider: p, availability: ProviderAvailabilityType.ENABLED);
      if ( !settings.contains(localSetting)) {
        settings.add(localSetting);
      }
    }
    return settings;
  }
  
  enable(String provider)  async {
    var updated = await api.postUpdateProviderSetting(ProviderSetting(provider: provider, availability: ProviderAvailabilityType.ENABLED));
    DATA = updated;
  }

  disable(String provider)  async {
    var updated = await api.postUpdateProviderSetting(ProviderSetting(provider: provider, availability: ProviderAvailabilityType.DISABLED));
    DATA = updated;
  }

  @override
  bool add(ProviderSetting data) {
    if (data.enabled) {
      enable(data.provider);
    } else{
      disable(data.provider);
    }
    return true;
  }

  @override
  seed() {
    loadProvidersSettings(_context).then((value){
      DATA = value;
    });
  }
}


/*
*
  var excludePublisher = [
    "부산일보",
    "국민일보",
    "중앙일보",
    "서울신문",
    "연합뉴스TV",
    "경향신문",
    "SBS",
    "MBC",
    "MBN",
    "머니S",
    "노컷뉴스",
    "세계일보",
    "스포츠서울",
    "스포츠조선",
    "일간스포츠",
    "인포스탁",
    "파이낸셜",
    "파이낸셜뉴스",
    "미디어오늘",
    "아이뉴스24",
    "강원일보",
    "KBS",
    "스포츠동아",
    "한겨레",
    "프레시안",
    "동아사이언스",
    "오마이뉴스",
    "채널A",
    "매일신문",
    "JTBC",
    "한국경제TV",
    "데일리안",
    "코메디닷컴",
    "조세일보"
  ];*/