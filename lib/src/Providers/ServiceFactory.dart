import 'package:firstapp/src/Providers/GetxProvider.dart';
import 'package:firstapp/src/Providers/Provider.dart';
import 'package:firstapp/src/Services/dioClient.dart';
import 'package:firstapp/src/Services/httpClient.dart';

class Servicefactory {
  static final Servicefactory _singleton = Servicefactory._internal();

  Servicefactory._internal();

  factory Servicefactory() => _singleton;

  final List<Map<String, dynamic>> _services = [
    {"dioClient": Dioclient()},
    {"httpClient": Httpclient()},
    {"getxProvider": GetxProvider()},
    {"provider": Provider()},
  ];

  static getService(String key) {
    return _singleton.returnService(key);
  }

  returnService(String key){
    return _services.firstWhere((element) => element.containsKey(key))[key];
  }
}
