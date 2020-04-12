import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inked/data/model/provider_setting.dart';
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

class ProvidersSelectionRepository {
  final BuildContext _context;
  ProvidersSelectionRepository(this._context);

  SharedPreferences _prefs;

  Future<List<String>> _setExcludedProviderList (List<String> list) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList(EXCLUDED_PROVIDERS_KEY, list);
    return list;
  }

  Future<List<String>> _loadExcludedProviderList () async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList(EXCLUDED_PROVIDERS_KEY) ?? [];
  }

  Future<List<ProviderSetting>> loadProvidersSettings () async {
    List<ProviderSetting> settings = [];
    var allProviders = await loadProvidersList(_context);
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
}
