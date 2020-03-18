// source: https://www.filledstacks.com/post/flutter-provider-v3-architecture/

import 'package:provider/provider.dart';

// local files
import 'package:provider_example/change_proxy_notifier_provider/services/data_verification_service.dart';
import 'package:provider_example/proxy_provider/services/api.dart'; // from ProxyProvider example

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(
    value: Api(),
  ),
];

List<SingleChildCloneableWidget> dependentServices = [
  ChangeNotifierProxyProvider<Api, DataVerificationService>(
    builder: (context, api, child) => DataVerificationService(api: api),
  )
];
