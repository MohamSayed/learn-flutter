// framework
import 'package:flutter/material.dart';

// packages
import 'package:provider/provider.dart';

// local files
import 'package:provider_example/proxy_provider/services/data_verification_service.dart';
import 'package:provider_example/proxy_provider/providers.dart';

class ProxyProviderExample extends StatelessWidget {
  const ProxyProviderExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If DataVerificationService was not a ProxyProvider, it will
    // not be able to fetch data from general model.
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          home: Scaffold(
            body: Consumer<DataVerificationService>(
              builder: (context, model, child) => ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                        title: Text(model.manipulateData()[index]),
                        dense: true,
                      )),
            ),
          ),
        ));
  }
}
