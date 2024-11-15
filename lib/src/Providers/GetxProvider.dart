import 'package:firstapp/src/Providers/ProviderInterface.dart';
import 'package:get/get.dart';

class GetxProvider extends GetxController implements ProviderInterface {
  void notifierChangement(){
    update();
  }
}