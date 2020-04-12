import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/model/provider_setting.dart';
import 'package:inked/data/repository/providers_selection_repository.dart';

class ProvidersSelectionScreen extends StatefulWidget {
  static const routeName = "settings/providers";

  @override
  State<StatefulWidget> createState() => _ProvidersSelectionScreenState();
}

class _ProvidersSelectionScreenState extends State<ProvidersSelectionScreen>
    with AfterLayoutMixin<ProvidersSelectionScreen> {
  ProvidersSelectionRepository repository;
  List<ProviderSetting> providerSettings = [];

  @override
  void afterFirstLayout(BuildContext context) {
    repository = ProvidersSelectionRepository();
    repository.loadProvidersSettings(context).then((value) {
      setState(() {
        providerSettings = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("prociders selection"),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (c, i) {
            var data = providerSettings[i];
            return ListTile(
              title: Text(data.provider),
              leading: Checkbox(
                  value: data.enabled,
                  onChanged: (c) async {
                    if (c) {
                      await repository.enable(data.provider);
                    } else {
                      await repository.disable(data.provider);
                    }
                    repository.loadProvidersSettings(context).then((value) {
                      setState(() {
                        providerSettings = value;
                      });
                    });
                  }),
            );
          },
          itemCount: providerSettings.length,
        ),
      ),
    );
  }
}
