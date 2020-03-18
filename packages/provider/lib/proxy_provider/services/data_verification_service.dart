import 'package:flutter/foundation.dart';
import 'package:provider_example/proxy_provider/services/api.dart';

class DataVerificationService {
  Api api;

  DataVerificationService({@required this.api});

  List<String> manipulateData() {
    return api.getData().map((f) => f.toString() + " Stringified").toList();
  }
}
