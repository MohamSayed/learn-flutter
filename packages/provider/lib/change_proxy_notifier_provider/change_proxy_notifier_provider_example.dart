// framework
import 'package:flutter/material.dart';

// packages
import 'package:provider/provider.dart';

// local files
import 'package:provider_example/change_proxy_notifier_provider/services/data_verification_service.dart';
import 'package:provider_example/change_proxy_notifier_provider/providers.dart';

class ChangeProxyNotifierProviderExample extends StatelessWidget {
  const ChangeProxyNotifierProviderExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If [DataVerificationService] was not a ProxyProvider, it will
    // not be able to fetch data from general model.
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text("Change Proxy Notifier Provider"),
            ),
            body: Consumer<DataVerificationService>(
                builder: (context, model, child) => ReorderableListView(
                    onReorder: model.reorderData,
                    children: model.data
                        .map((f) => Dismissible(
                            background: Container(
                              color: Colors.redAccent,
                              child: Center(child: Text("Dismissing")),
                            ),
                            key: Key(f),
                            onDismissed: (direction) {
                              model.deleteByIndex(int.parse(f));
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Dismissed: $f"),
                              ));
                            },
                            child: Card(
                                child: ListTile(
                              leading: Text(f),
                              title: Text(">>>>>>"),
                            ))))
                        .toList())),
          ),
        ));
  }
}
