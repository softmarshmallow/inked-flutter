import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inked/data/model/provider_setting.dart';
import 'package:inked/data/repository/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  SharedPreferences _prefs;

  BuildContext _context;
  setContext(BuildContext context){
    _context = context;
  }

  Future<List<String>> _setExcludedProviderList (List<String> list) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList(EXCLUDED_PROVIDERS_KEY, list);
    return list;
  }

  Future<List<String>> _loadExcludedProviderList () async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList(EXCLUDED_PROVIDERS_KEY) ?? [];
  }

  Future<List<ProviderSetting>> loadProvidersSettings (BuildContext context) async {
    List<ProviderSetting> settings = [];
    var allProviders = await loadProvidersList(context);
    var excluded = await _loadExcludedProviderList();
    for (var p in allProviders){
      bool enabled = !excluded.contains(p);
      settings.add(new ProviderSetting(provider: p, enabled: enabled));
    }
    return settings;
  }
  
  enable(String provider)  async {
    var updated = (await _loadExcludedProviderList())..remove(provider);
    await _setExcludedProviderList(updated);
  }

  disable(String provider)  async {
    await _setExcludedProviderList((await _loadExcludedProviderList())..add(provider));
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

  @override
  set(List<ProviderSetting> data) {
    DATA = data;
    var excludeList = [];
    for (var d in DATA){
      if (!d.enabled) {
        excludeList.add(d.provider);
      }
    }
    _setExcludedProviderList(excludeList);
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