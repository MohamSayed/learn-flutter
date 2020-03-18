// source: https://www.filledstacks.com/post/flutter-provider-v3-architecture/

import 'package:provider/provider.dart';
import 'package:provider_example/proxy_provider/services/api.dart';
import 'package:provider_example/proxy_provider/services/data_verification_service.dart';


List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(
    value: Api(),
  ),
];

List<SingleChildCloneableWidget> dependentServices = [

  ProxyProvider<Api, DataVerificationService>(
    builder: (context, generalModel, child) =>
        DataVerificationService(api: generalModel),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [];
