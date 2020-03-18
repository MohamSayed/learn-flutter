import 'package:flutter/foundation.dart';

// from proxy provider example
import 'package:provider_example/proxy_provider/services/api.dart';

class DataVerificationService extends ChangeNotifier {
  Api api;

  DataVerificationService({@required this.api}) {
    manipulateData();
  }

  List<String> data;
  void manipulateData() {
    data = api.getData().map((f) => f.toString()).toList();
    notifyListeners();
  }

  void deleteByIndex(int index) {
    data.removeAt(index);
    notifyListeners();
  }

  void reorderData(int oldPosition, int newPosition) {
    var item = data[oldPosition];
    data.removeAt(oldPosition);
    data.insert(newPosition, item);
    notifyListeners();
    print("Data reodered");
  }
}
