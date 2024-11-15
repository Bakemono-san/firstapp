import 'package:firstapp/src/Services/DependencyContainer.dart';


class Datahandler {

  final client = DependencyContainer.getDependency("client");

  Future delete(String url) {
    throw UnimplementedError();
  }

  Future get(String url) {
    throw UnimplementedError();
  }

  Future patch(String url, data) {
    throw UnimplementedError();
  }

  Future post(String url, data) {
    throw UnimplementedError();
  }

  Future put(String url, data) {
    throw UnimplementedError();
  }

}